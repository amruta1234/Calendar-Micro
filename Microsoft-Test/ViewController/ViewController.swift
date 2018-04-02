//
//  ViewController.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 12/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weekdaysLabel: UIView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 0.0, right: 1.0)
    fileprivate let itemsPerRow: CGFloat = 7
    var collectionTap = false
    var expanded = true

    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var viewModel: CalendarViewModel = CalendarViewModel(eventStore: EventStore())
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.delegate = self
        setupCollectionView()
        setupTableView()

        //Navagation item tap
        let gesture = UITapGestureRecognizer(target: self, action: #selector(navigationItemTapGesture))
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
        self.navigationController?.navigationBar.addGestureRecognizer(gesture)
        
        //CollectionView pan gesture
        let panGestureCollection = UIPanGestureRecognizer(target: self, action: #selector(pangestureCollectionView(recog:)))
        self.collectionView.addGestureRecognizer(panGestureCollection)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.requestAccessForCalendar()
    }
    
    //MARK: View set up functions
    func setupTableView() {
        self.tableView.register(UINib(nibName:"EventTableViewCell", bundle: nil), forCellReuseIdentifier: "eventCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        if let date = viewModel.currentDate.date {
            offsetTableView(date: date)
        }
    }
    
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let calendarTitleView = CalendarTitleView(frame: CGRect(x:0, y:0, width: self.weekdaysLabel.frame.size.width, height: self.weekdaysLabel.frame.size.height))
        self.weekdaysLabel.addSubview(calendarTitleView)

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
        }
    }
    
    
    //MARK: View offset functions
    func offsetTableView(date:Date) {
        if let path = viewModel.getOffsetForDate(date: date) {
            let eventPath = IndexPath(row: 0, section: path.row)
            self.tableView.scrollToRow(at: eventPath, at: .top, animated: true)
        }
    }
    
    
    func offsetCalendarView(date: Date) {
        if let path = viewModel.getOffsetForDate(date: date) {
            collectionView.layoutIfNeeded()
            collectionView.scrollToItem(at: path, at: .centeredVertically, animated: true)
        }
    }
    
    
    @objc func navigationItemTapGesture() {
        if expanded == true{
            collapseCalendarView()
        }else{
            expandCalendarView()
        }
    }
    
    @objc func pangestureCollectionView(recog: UIGestureRecognizer) {
        if expanded == false{
            expandCalendarView()
        }
    }
    
    @objc func pangestureTableView(recog: UIPanGestureRecognizer){
        let translation = recog.translation(in: self.view)
        print(translation)
    }
    
    func expandCalendarView() {
        self.collectionViewHeight.constant = Calendar_CollectionViewHeight_Expanded
        expanded = true
        animateCalendarViews()
    }
    
    func collapseCalendarView() {
        self.collectionViewHeight.constant = Calendar_CollectionViewHeight_Collapsed * 2 + 10
        self.expanded = false
        animateCalendarViews()
    }
    
    func animateCalendarViews() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }) { (complete) in
            if let currentDate = self.viewModel.currentDate.date{
                self.offsetCalendarView(date: currentDate)
            }
        }
    }
    
    func updateHeader(_ headerTxt: String) {
        self.navigationItem.title = headerTxt
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: Callback functions from viewmodel
extension ViewController: ViewControllerCallbacks {
    func showCalendarPermissionAlert() {
        //TODO show alert view controller
    }
    
    func currentDateSelectedCallback() {
        viewModel.currentDate.selected = true
        if let newDate = viewModel.currentDate.date {
            offsetCalendarView(date: newDate)
            self.collectionView.reloadData()
            offsetTableView(date: newDate)
        }
    }
    
    func currentDateUnslectedCallback() {
        viewModel.currentDate.selected = false
        self.collectionView.reloadData()
    }
}
