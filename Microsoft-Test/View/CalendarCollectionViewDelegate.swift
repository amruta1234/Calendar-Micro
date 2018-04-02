//
//  CalendarCollectionViewDataSource.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 15/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation
import UIKit

fileprivate let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 0.0, right: 1.0)
fileprivate let itemsPerRow: CGFloat = 7


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.calendarRows.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarTableViewCell",for: indexPath) as! CalendarTableViewCell
        let eachDate = viewModel.calendarRows[indexPath.row]
        cell.dateLabel.text = String(eachDate.day)
        
        let presentDate = viewModel.presentDate
        
        if eachDate.selected == true {
            updateHeader(CalenderHelper.getMonthString(eachDate.month))
            cell.dateLabel.backgroundColor = Constants.COLORS.selectedColor
            cell.dateLabel.textColor = UIColor.white
            cell.dateLabel.layer.cornerRadius = cell.dateLabel.frame.size.width / 2
            cell.dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
            
        }else if presentDate.month != eachDate.month {
            cell.dateLabel.textColor = Constants.COLORS.preColor
            cell.dateLabel.backgroundColor = UIColor.clear
            cell.dateLabel.layer.cornerRadius = 0.0
            cell.dateLabel.font = UIFont.systemFont(ofSize: 14)
            
        }else {
            cell.dateLabel.textColor = UIColor.black
            cell.dateLabel.backgroundColor = UIColor.clear
            cell.dateLabel.layer.cornerRadius = 0.0
            cell.dateLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionTap = true
//        print("Selected date:\(viewModel.calendarRows[indexPath.row].date)")
        viewModel.currentDate = viewModel.calendarRows[indexPath.row]
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.size.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
