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


    var viewModel: CalendarViewModel = CalendarViewModel(eventStore: EventStore())
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.delegate = self
        setupCollectionView()
        setupTableView()
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
