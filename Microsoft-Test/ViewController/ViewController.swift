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

    var viewModel:CalendarViewModel = CalendarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    func initialSetup(){
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
        
        //Update calendar collection view
        viewModel.calendarRows = viewModel.getYearData(date: Date())
        self.collectionView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}



