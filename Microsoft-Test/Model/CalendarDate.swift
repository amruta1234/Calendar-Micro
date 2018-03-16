//
//  CalendarDate.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 14/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation

struct CalendarDate{
    let date: Date
    let month:Int
    let year:Int
    
    init(date: Date) {
        self.date = date
        self.month = Calendar.current.component(.month, from: date)
        self.year = Calendar.current.component(.year, from: date)
    }
    
    func getNumberOfDaysInMonth() -> Int{
        if month > 12{
            return 0
        }
        var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
        if year % 4 == 0 && month == 2{
            numOfDaysInMonth[2] = 29
        }
        return numOfDaysInMonth[month - 1]
    }
    
    func getWeekdayForFirstDate() -> Int{
        let weekdate =  Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: date))!
        return Calendar.current.component(.weekday, from: weekdate)
    }
    
}
