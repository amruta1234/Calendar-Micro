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
   
    func requestAccessForCalendar(){
        self.eventStore.requestAccess(to: .event) { (permission, error) in
            if permission == true{
                print("Granted")
            }else{
                print("Not granted")
            }
        }
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
   
    
    func getNums(){
        let dateComponents = DateComponents(year: 2015, month: 7)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        print(numDays) // 31
    }
}
