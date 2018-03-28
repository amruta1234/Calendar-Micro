//
//  CalendarViewModel.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 12/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation
import EventKit
import EventKitUI

class CalendarViewModel{
    var eventStore =  EKEventStore()
    var calendarRows = [CalendarDisplay]()
    var currentDate = CalendarDisplay(date: Date())

    func requestAccessForCalendar(){
        self.eventStore.requestAccess(to: .event) { (permission, error) in
            if permission == true{
                print("Granted")
            }else{
                print("Not granted")
            }
        }
    }
    
    func fetchEvents(date:Date) -> [EventDisplay]{
        let calendars = self.eventStore.calendars(for: .event)
        let predicate = self.eventStore.predicateForEvents(withStart: date, end: date, calendars:calendars)
        let events = self.eventStore.events(matching: predicate)
        
        var eventsList = [EventDisplay]()
        for eachEvent in events{
            let newDisplay = EventDisplay(title: eachEvent.title, image: "", time:eachEvent.startDate.description)
            print("Event - \(newDisplay.title)")
            eventsList.append(newDisplay)
        }
        return eventsList
    }
    
    func getYearData(date: Date) -> [CalendarDisplay]{
        var calendarRows = [CalendarDisplay]()
        
        let presentYear = Calendar.current.component(.year, from: date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let firstDate = formatter.date(from: "\(presentYear)/01/01")
        let firtweekday = self.getWeekdayForFirstDate(date: firstDate!)
        
        for _  in 1...(firtweekday - 1){
            let newDate = CalendarDisplay(day: 0, month: 0, year: 0)
            calendarRows.append(newDate)
        }
        
        for month in 1...12{
            let n = getNumberOfDaysInMonth(month: month, year: presentYear)
            for date in 1...n{
                var newDate = CalendarDisplay(day: date, month: month, year: presentYear    )
                if newDate == currentDate{
                    newDate.selected = true
                }
                calendarRows.append(newDate)
            }
        }
        return calendarRows
    }
    
    func getNumberOfDaysInMonth(month: Int, year: Int) -> Int{
        if month > 12{
            return 0
        }
        var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
        if year % 4 == 0 && month == 2{
            numOfDaysInMonth[2] = 29
        }
        return numOfDaysInMonth[month - 1]
    }
    
    func getWeekdayForFirstDate(date:Date) -> Int{
        let weekdate =  Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: date))!
        return Calendar.current.component(.weekday, from: weekdate)
    }
    
    func getOffsetForDate(date:Date) -> IndexPath?{
        let currentDay = Calendar.current.component(.day, from: date)
        let currentMonth = Calendar.current.component(.month, from: date)
        let currentYear = Calendar.current.component(.year, from: date)

        let row = calendarRows.index { (date) -> Bool in
            date.day == currentDay && date.month == currentMonth && date.year == currentYear
        }
        if let rows = row{
            let path = IndexPath(row: rows, section: 0)
            return path
        }
        return nil
    }
    
}

