//
//  File.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 29/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation
import EventKit

typealias permissionCallback = (Bool) -> Void

protocol IEventStore {
    func requestAccessToCalendar(callback:@escaping permissionCallback)
    func fetchEvents(_ currentdate:CalendarDisplay) -> [EventDisplay]
}


class EventStore: IEventStore{
    var eventStore =  EKEventStore()
    
    func requestAccessToCalendar(callback:@escaping permissionCallback){
        self.eventStore.requestAccess(to: .event) { (permission, error) in
            if permission != true{
                callback(true)
            }else{
                callback(false)
            }
        }
    }
    
    func fetchEvents(_ currentdate:CalendarDisplay) -> [EventDisplay]{
        var eventsList = [EventDisplay]()
        
        if let date = currentdate.date{
            let calendars = self.eventStore.calendars(for: .event)
            
            let next = Calendar.current.date(byAdding: .day, value: 1, to: date)
            
            let predicate = self.eventStore.predicateForEvents(withStart: date, end: next!, calendars:calendars)
            let events = self.eventStore.events(matching: predicate)
            
            for eachEvent in events{
                let newDisplay = EventDisplay(title: eachEvent.title, image: "", time:eachEvent.startDate.description)
                eventsList.append(newDisplay)
            }
            if eventsList.count == 0{
                eventsList.append(EventDisplay(title: "None", image: "", time: ""))
            }
        }
        return eventsList
    }
}
