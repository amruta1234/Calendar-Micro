//
//  CalendarTitleView.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 02/04/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation
import UIKit

class CalendarTitleView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        // Draw the weekday label
        let weekDays = ["S", "M", "T", "W", "T", "F", "S"]
        let eachWidth = UIScreen.main.bounds.size.width/7
        
        var xOffset:CGFloat = 0.0
        for eachWeekday in weekDays {
            let label = UILabel(frame: CGRect(x:Int(xOffset), y:0, width: Int(eachWidth), height: 30))
            label.text = eachWeekday
            label.textAlignment = .center
            self.addSubview(label)
            xOffset = xOffset + eachWidth
        }
    }
}
