//
//  CalendarViewModelTests.swift
//  Microsoft-Unit-Tests
//
//  Created by Amruta Itagi on 29/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation
import XCTest

class MockViewController: ViewControllerCallbacks{
    var showCalendarCalled = false
    func showCalendarPermissionAlert() {
        showCalendarCalled = true
    }
}

class CalendarViewModelTests: XCTest{
    
    var viewModel: CalendarViewModel!
    var mockEventStore: MockEventStore!
    var mockViewController: MockViewController!
    
    override func setUp() {
        mockEventStore = MockEventStore()
        mockViewController = MockViewController()
        viewModel = CalendarViewModel(eventStore: mockEventStore)
        viewModel.delegate = mockViewController
        super.setUp()
    }
    
    func testEventStoreRequestAccess(){
        viewModel.requestAccessForCalendar()
        mockEventStore.permission?(false)
        XCTAssert(mockViewController.showCalendarCalled == true, "When event store access not given , view controller alert not called")
    }
    
    func testFetchEvents(){
        mockEventStore.mockEvents = getTestEvents()
        let events = viewModel.fetchEvents(CalendarDisplay(date:Date()))
        XCTAssert(events.count == 2, "Events not passed properly")
    }
    
    func testFetchGetYearData(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let testDate = formatter.date(from: "2018/01/01")
        let dates = viewModel.getYearData(date: testDate!)
        XCTAssert(dates.count == 366, "number of days in years not calculated properly")
    }
    
    func testFetchGetNumberOfDays(){
        let days = viewModel.getNumberOfDaysInMonth(month: 1, year: 2018)
        XCTAssert(days == 31, "Month days calculated wrong")
    }
    
    func testWeekdayForFirstDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let testDate = formatter.date(from: "2017/12/31")
        let weekday = viewModel.getWeekdayForFirstDate(date: testDate!)
        XCTAssert(weekday == 2, "Weekday calculated wrongly")
    }
    
    func testGetOffset(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let testDate = formatter.date(from: "2018/03/29")
        let indexpath = viewModel.getOffsetForDate(date: testDate!)
        XCTAssert(indexpath?.row == 3, "Offset calculated wrongly")
    }
    
    
    //MARK: Helpers
    func getTestEvents() -> [EventDisplay]{
        var events = [EventDisplay]()
        let event1 = EventDisplay(title: "test1", image: "", time: "")
        let event2 = EventDisplay(title: "test2", image: "", time: "")
        events.append(event1)
        events.append(event2)
        return events
    }
    
    override func tearDown() {
        viewModel = nil
        mockEventStore = nil
        super.tearDown()
    }
}
