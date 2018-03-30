//
//  MockEventStore.swift
//  Microsoft-Unit-Tests
//
//  Created by Amruta Itagi on 29/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation

class MockEventStore: IEventStore{
    
    var permission:((Bool) -> Void)?
    var mockEvents:[EventDisplay] = [EventDisplay]()
    
    func requestAccessToCalendar(callback: @escaping (Bool) -> Void) {
        permission = callback
    }
    
    func fetchEvents(_ currentdate: CalendarDisplay) -> [EventDisplay] {
        return mockEvents
    }
    
}
