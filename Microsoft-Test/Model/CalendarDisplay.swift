//
//  CalendarDisplay.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 15/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation

class CalendarDisplay{
    var day:Int
    var month:Int
    var year:Int
    var selected = false
    var events = [EventDisplay]()
    var date:Date?
    
    init(day:Int, month:Int , year:Int) {
        self.day = day
        self.month = month
        self.year = year
        self.events.append(emptyEvent())
        self.date = getDate(day: day, month: month, year: year)
    }
    
    init(date: Date) {
        self.day  = Calendar.current.component(.day, from: date)
        self.month = Calendar.current.component(.month, from: date)
        self.year = Calendar.current.component(.year, from: date)
        self.events.append(emptyEvent())
        self.date = date
    }
    
    func getDate(day:Int, month:Int , year:Int) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = formatter.date(from: "\(year)/\(month)/\(day) 00:00:00")
        return date
    }
    
    func emptyEvent() -> EventDisplay{
        return EventDisplay(title: "none", image: "", time: "")
    }
    
    func getDay() -> String{
        return "\(day)-\(month)-\(year)-\(selected)"
    }
    
    func printDate(){
        print("\(day)-\(month)-\(year)-\(selected)")
    }
}

extension CalendarDisplay: Equatable{
    static func ==(lhs: CalendarDisplay, rhs: CalendarDisplay) -> Bool {
        if lhs.day == rhs.day && lhs.month == rhs.month && lhs.year == rhs.year{
            return true
        }
        return false
    }
    
}
