//
//  ViewController.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 12/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weekdaysLabel: UIView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 0.0, right: 1.0)
    fileprivate let itemsPerRow: CGFloat = 7


    var viewModel:CalendarViewModel = CalendarViewModel(eventStore: EventStore())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupCollectionView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.requestAccessForCalendar()
    }
    
    func setupTableView(){
        self.tableView.register(UINib(nibName:"EventTableViewCell", bundle: nil), forCellReuseIdentifier: "eventCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        if let date = viewModel.currentDate.date{
            offsetTableView(date: date)
        }
    }
    
    func offsetTableView(date:Date){
        if let path = viewModel.getOffsetForDate(date: date){
            let eventPath = IndexPath(row: 0, section: path.row)
            self.tableView.scrollToRow(at: eventPath, at: .top, animated: true)
        }
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Draw the weekday label
        let weekDays = ["S", "M", "T", "W", "T", "F", "S"]
        let eachWidth = UIScreen.main.bounds.size.width/7
        
        var xOffset:CGFloat = 0.0
        for eachWeekday in weekDays{
            let label = UILabel(frame: CGRect(x:Int(xOffset), y:0, width: Int(eachWidth), height: 44))
            label.text = eachWeekday
            label.textAlignment = .center
            self.weekdaysLabel.addSubview(label)
            xOffset = xOffset + eachWidth
        }
        
        //Show the current date
        if let date = viewModel.currentDate.date{
            self.reloadCalendarView(date: date)
            self.offsetCalendarView(date: date)
        }
    }
    
    //Update calendar collection view
    func reloadCalendarView(date: Date){
        viewModel.calendarRows = viewModel.getYearData(date: date)
        self.collectionView.reloadData()
    }
    
    func offsetCalendarView(date: Date){
        if let path = viewModel.getOffsetForDate(date: date){
            collectionView.layoutIfNeeded()
            collectionView.scrollToItem(at: path, at: .centeredVertically, animated: true)
        }
    }
    
    //Delegate callbacks
    func currentdateChangeCollectionView(_ date:CalendarDisplay){
        if let newDate = date.date{
            viewModel.currentDate.selected = false
            date.selected = true
            viewModel.currentDate = date
            offsetCalendarView(date: newDate)
            //TODO: only reload the cells not whole table view
            self.collectionView.reloadData()
        }
    }
   
    
    func currentDateChangeTableView(_ date:CalendarDisplay){
        if let newDate = date.date{
            viewModel.currentDate.selected = false
            date.selected = true
            viewModel.currentDate = date
            offsetTableView(date: newDate)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: ViewControllerCallbacks{
    func showCalendarPermissionAlert() {
        //TODO show alert view controller
    }
}





