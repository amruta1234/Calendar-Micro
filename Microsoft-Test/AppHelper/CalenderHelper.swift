//
//  CalenderHelper.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 3/30/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation
import UIKit

let Calendar_CollectionViewHeight_Expanded: CGFloat = 200.00
let Calendar_CollectionViewHeight_Collapsed: CGFloat = CalenderHelper.getCalendarHeight()
let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 0.0, right: 1.0)
let itemsPerRow: CGFloat = 7

struct Constants {
    struct COLORS {
        static let preColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.51)
        static let selectedColor = UIColor(red: 17.0/255.0, green: 116.0/255.0, blue: 195.0/255.0, alpha: 1)
        static let sectionBGColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1)
        static let selectedSectionBGColor = UIColor(red: 224.0/255.0, green: 236.0/255.0, blue: 249.0/255.0, alpha: 1)
    }
}

class CalenderHelper {
    
    static var monthsStringVal = [1: "January",
                                  2: "February",
                                  3: "March",
                                  4: "April",
                                  5: "May",
                                  6: "June",
                                  7: "July",
                                  8: "August",
                                  9: "September",
                                  10: "October",
                                  11: "November",
                                  12: "December"]
    
    class func getMonthString(_ month:Int) -> String {
        return self.monthsStringVal[month] ?? ""
    }
    
    class func getCalendarHeight() -> CGFloat{
       let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.size.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return widthPerItem
    }
}
