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
    
    func getDate(year: Int? = nil, month: Int? = nil, day: Int? = nil,of date: Date = Date()) -> Date {
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        if let year = year, let month = month, let day = day {
            guard let dateFromComp = calendar.date(from: DateComponents(year: year, month: month, day: day)) else {
                return calendar.startOfDay(for: Date())
            }
            return calendar.startOfDay(for: dateFromComp)
        } else {
            return calendar.startOfDay(for: date)
        }
    }
    
    func getDateRange() -> ClosedRange<Date> {
        guard let year = calendar.dateComponents(in: TimeZone(identifier: "Asia/Seoul")!, from: Date()).year else {
            print(#function, "날짜를 찾을 수 없습니다.")
            return ClosedRange<Date>(uncheckedBounds: (Date(), Date()))
        }
        let first = getDate(year: year - 1, month: 1, day: 1)
        let last = getDate(year: year + 1, month: 12, day: 31)
        
        return first...last
    }
    
    func getYearRange() -> [String] {
        guard let year = calendar.dateComponents(in: TimeZone(identifier: "Asia/Seoul")!, from: Date()).year else {
            return []
        }
        return [Int]((year - 1)...(year + 1)).map {
            year in String(format: "%04d", year)
        }
    }
    
    func getLastDay(year: Int, month: Int) -> Int {
        let date = getDate(year: year, month: month + 1, day: 1) - 86400
        let day = calendar.dateComponents([.day], from: date)
        return day.day ?? 0
    }
    
    func getWeekday(year: Int, month: Int, day: Int) -> Int {
        guard let date = calendar.date(from: DateComponents(year: year, month: month, day: day)) else {
            print("Invalid date")
            return 0
        }
        
        let weekday = calendar.component(.weekday, from: date)
        return weekday
    }
    
    func getDays(year: Int, month: Int) -> Int {
        let days = getLastDay(year: year, month: month)
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

