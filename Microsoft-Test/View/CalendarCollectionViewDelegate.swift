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
        return cell
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.calendarRows.count - 1){
            print("Reached end")
            let path = IndexPath(row: 20, section: 0)
            collectionView.scrollToItem(at: path, at: .top, animated: true)
        }
        if indexPath.row == 0{
            print("First")
        }
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
