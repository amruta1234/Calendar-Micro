//
//  EventDisplay.swift
//  Microsoft-Test
//
//  Created by Amruta Itagi on 27/03/18.
//  Copyright © 2018 Amruta Itagi. All rights reserved.
//

import Foundation

struct EventDisplay {
    
    let title:String
    let imageName:String
    var time: String = ""
    var allDay: Bool = false
    var startTime: String = ""
    
    init(title:String, image:String, duration: TimeInterval = 0, isAllDay: Bool = false, startTime: Date? = nil) {
        self.title = title
        self.imageName = image
        if isAllDay {
            self.time = "All Day"
        } else {
            self.time = self.getDurationStringFromSeconds(duration)
        }
        self.allDay = isAllDay
        if let startDate = startTime {
            self.startTime = self.getTimeString(startDate)
        }
    }
    
    private func getDurationStringFromSeconds(_ duration: TimeInterval) -> String {
        return getDurationStringFromMinutes(duration/60)
    }
    
    private func getDurationStringFromMinutes(_ duration: TimeInterval) -> String {
        var hrs:Int = Int(duration / 60)
        var mins:Int = Int(duration.truncatingRemainder(dividingBy: 60))
        if mins == 60 {
            hrs = hrs + 1
            mins = 00
        }
        var durationString = ""
        if hrs > 0 {
            if mins == 0 {
                durationString = "\(hrs) hr"
            }else {
                durationString = "\(hrs) hr \(mins) mins"
            }
        } else {
            durationString = "\(mins)"
        }
        
        return durationString
    }
    
    private func getTimeString(_ startTime: Date) -> String {
        let hour = Calendar.current.component(.hour, from: startTime)
        let mins = Calendar.current.component(.minute, from: startTime)
        return String(format: "%02d", hour) + ":" + String(format: "%02d", mins)
    }
}
