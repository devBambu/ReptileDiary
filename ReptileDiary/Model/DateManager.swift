//
//  DateManager.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/11/25.
//

import Foundation
import SwiftUI

class DateManager {
    static var shared = DateManager()
    
    var calendar = Calendar.current

    var formatter = DateFormatter()
    
    func getDate(year: Int, month: Int, day: Int) -> Date {
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!

        guard let date = calendar.date(from: DateComponents(year: year, month: month, day: day)) else {
            return getDateNoTime(of: Date())
        }
        
        let timeDifference = Double(calendar.timeZone.secondsFromGMT(for: date))
        
        return date + timeDifference
    }
    
    func getDateNoTime(of date: Date) -> Date {
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        let timeDifference = Double(calendar.timeZone.secondsFromGMT(for: date))
        
        let components = calendar.dateComponents([.year, .month, .day], from: date + timeDifference)
        let noTimeDate = calendar.date(from: components)!
        
        return noTimeDate
    }
    
    func getYearRange() -> [String] {
        let date = getDateNoTime(of: Date())
        let today = calendar.dateComponents([.year], from: date)
        guard let year = today.year else { return [] }
        return [Int]((year - 2)...(year + 2)).map { year in
            String(format: "%04d", year)
        }
    }
    
    func getLastDay(of month: Int) -> Int {
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 2:
            return 28
        case 4, 6, 9, 11:
            return 30
        default:
            return 0
        }
    }
    
    func getWeekday(year: Int, month: Int, day: Int) -> Int {
        guard let date = calendar.date(from: DateComponents(year: year, month: month, day: day)) else {
            print("Invalid date")
            return 0
        }
        
        let weekday = calendar.component(.weekday, from: date)
        return weekday
    }
    
    func getRange(year: Int, month: Int) -> Int {
        let days = getLastDay(of: month)
        let firstWeekday = getWeekday(year: year, month: month, day: 1)
        
        return firstWeekday == 1 ? days + 6 : days + (firstWeekday - 2)
    }
    
    
    func dateFormat(_ date: Date) -> String {
        // guard let date = selectedDate else { return "" }
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일 EEEE"
        return formatter.string(from: date)
    }
}

