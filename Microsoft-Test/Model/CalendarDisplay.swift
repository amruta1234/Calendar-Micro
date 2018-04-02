//
//  CalendarDisplay.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 15/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation

class CalendarDisplay {
    
    var day: Int
    var month: Int
    var year: Int
    var selected = false
    var events = [EventDisplay]()
    var date: Date?
    var isToday: Bool = false
    var isYesturday: Bool = false
    var isTomorrow: Bool = false
    var dateString: String = ""
    
    init(day:Int, month:Int , year:Int) {
        
        self.day = day
        self.month = month
        self.year = year
        self.events.append(emptyEvent())
        self.date = getDate(day: day, month: month, year: year)
        if let wrappedDate = date {
            isToday = Calendar.current.isDateInToday(wrappedDate)
            isYesturday = Calendar.current.isDateInYesterday(wrappedDate)
            isTomorrow = Calendar.current.isDateInTomorrow(wrappedDate)
            
        }
        dateString = getDayString()
    }
    
    init(date: Date) {
        self.day  = Calendar.current.component(.day, from: date)
        self.month = Calendar.current.component(.month, from: date)
        self.year = Calendar.current.component(.year, from: date)
        self.events.append(emptyEvent())
        self.date = date
    }
    
    func getDate(day:Int, month:Int , year:Int) -> Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = formatter.date(from: "\(year)/\(month)/\(day) 12:00:01")
        return date
    }
    
    func emptyEvent() -> EventDisplay {
        return EventDisplay(title: "none", image: "", isAllDay: false)
    }
    
    private func getDayString() -> String {
        if let currDate = date {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
            var currDateString: String = dateFormatter.string(from: currDate)
            
            if isToday || isTomorrow || isYesturday {
                let dateString = currDateString.components(separatedBy: ",")
                var startString:String = dateString[0]
                if isToday {
                    startString = "Today"
                }else if isYesturday {
                    startString = "Yesterday"
                }else if isTomorrow {
                    startString = "Tomorrow"
                }
                currDateString = startString + "," + dateString[1] + "," + dateString[2]
            }
            
            return currDateString
        }
        return ""
    }
}

extension CalendarDisplay: Equatable {
    
    static func ==(lhs: CalendarDisplay, rhs: CalendarDisplay) -> Bool {
        if lhs.day == rhs.day && lhs.month == rhs.month && lhs.year == rhs.year && lhs.date == rhs.date{
            return true
        }
        return false
    }
    
}
