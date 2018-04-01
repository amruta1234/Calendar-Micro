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
        let date = viewModel.calendarRows[section]
        return date.getDay()
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
    
   func getPinnedSection() -> Int?{
        if tableView.visibleCells.count > 0{
            if let section = tableView.indexPath(for: tableView.visibleCells[0])?.section{
                if section < viewModel.calendarRows.count{
                    return section
                }
            }
        }
        return nil
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        collectionTap = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if collectionTap == false{
            if let section = getPinnedSection(){
                viewModel.currentDate = viewModel.calendarRows[section]
            }
        }
        collectionTap = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionTap == false{
            if let section = getPinnedSection(){
                let date = viewModel.calendarRows[section]
                if date != viewModel.currentDate{
                    viewModel.currentDate = date
                }
            }
        }
    }
    
}


