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
    
    let calendar = Calendar.current
    lazy var today = calendar.dateComponents(in: .current, from: Date())
    
    func getYearRange() -> [String] {
        guard let year = today.year else { return [] }
        return [Int]((year - 2)...(year + 2)).map { year in
            String(format: "%04d", year)
        }
    }
    
    func getDays(@Binding of month: String) -> Range<Int> {
        switch month {
        case "1", "3", "5", "7", "8", "10", "12":
            print(Range<Int>(1...31))
            return Range<Int>(1...31)
        case "2":
            print(Range<Int>(1...28))
            return Range<Int>(1...28)
        case "4", "6", "9", "11":
            print(Range<Int>(1...30))
            return Range<Int>(1...30)
        default:
            print(Range<Int>(0...0))
            return Range<Int>(0...0)
        }
    }
    
}
