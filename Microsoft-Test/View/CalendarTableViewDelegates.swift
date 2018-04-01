//
//  CalendarTableViewDelegates.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 27/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.calendarRows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let eachDate = viewModel.calendarRows[section]
        return eachDate.dateString
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:15))
        let label = UILabel(frame: CGRect(x:10, y:7, width:tableView.frame.size.width, height:15))
        label.font = UIFont.systemFont(ofSize: 14)
        let eachDate = viewModel.calendarRows[section]
        if eachDate.isToday {
            label.textColor = Constants.COLORS.selectedColor
            view.backgroundColor = Constants.COLORS.selectedSectionBGColor
        } else {
            label.textColor = Constants.COLORS.preColor
            view.backgroundColor = Constants.COLORS.sectionBGColor
        }
        label.text = eachDate.dateString
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = viewModel.calendarRows[section]
        return date.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let date = viewModel.calendarRows[indexPath.section]
        let event = date.events[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        cell.eventTitle.text = event.title
        cell.timeLabel.text = String(event.time)
        if event.allDay {
            cell.timeLabel.textColor = UIColor.green
        }else {
            cell.timeLabel.textColor = UIColor.blue
        }
        cell.imageView?.layer.cornerRadius = 10
        cell.duration.text = event.startTime
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension ViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let visible = self.tableView.indexPathsForVisibleRows?.count{
            if indexPath.section - visible > 0{
                let date = viewModel.calendarRows[indexPath.section - visible]
                self.currentdateChangeCollectionView(date)
            }
        }
        
        
    }

    
    
}


