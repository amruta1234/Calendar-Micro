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
    
    init(day:Int, month:Int , year:Int) {
        self.day = day
        self.month = month
        self.year = year
        self.events.append(emptyEvent())
    }
    
    init(date: Date) {
        self.day  = Calendar.current.component(.day, from: date)
        self.month = Calendar.current.component(.month, from: date)
        self.year = Calendar.current.component(.year, from: date)
        self.events.append(emptyEvent())
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
