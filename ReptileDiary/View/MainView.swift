//
//  MainView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/10/25.
//

import SwiftUI

struct MainView: View {
    let dateManager = DateManager.shared
    
    @State private var selectedYear: String = "2025"
    @State private var selectedMonth: String = "11"
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let weekday = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        HStack {
            Picker("Year", selection: $selectedYear) {
                let yearRange = dateManager.getYearRange()
                ForEach(Range<Int>(0...4)) {
                    Text(yearRange[$0]).tag(yearRange[$0])
                }
            } currentValueLabel: {
                Text("\(selectedYear)년")
            }
            
            Picker("Month", selection: $selectedMonth) {
                ForEach(Range<Int>(1...12)) {
                    Text("\($0)").tag("\($0)")
                }
            } currentValueLabel: {
                Text("\(selectedMonth)월")
            }
        }
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 5) {
                let range = dateManager.getDays($of: $selectedMonth)
                ForEach(0..<38) { idx in
                    if idx < 7 {
                        Text(weekday[idx])
                            .font(.headline)
                            .foregroundColor(weekday[idx] == "일" ? Color.red : .black)
                    }
                    else {
                        Text("\(idx - 6)")
                    }
                }
                .frame(width: 40, height: 40)
                .padding(1)
                .background(Color.white)
            }
        }
        .frame(width: 330, height: 300)
    }
}

#Preview {
    MainView()
}

//struct yearMonthPicker: View {
//    let dateManager = DateManager.shared
//    
//    @State private var selectedYear: String = "2025"
//    @State private var selectedMonth: String = "11"
//    
//    var body: some View {
//        HStack {
//            Picker("Year", selection: $selectedYear) {
//                let yearRange = dateManager.getYearRange()
//                ForEach(Range<Int>(0...4)) {
//                    Text(yearRange[$0]).tag(yearRange[$0])
//                }
//            } currentValueLabel: {
//                Text("\(selectedYear)년")
//            }
//            
//            Picker("Month", selection: $selectedMonth) {
//                ForEach(Range<Int>(1...12)) {
//                    Text("\($0)").tag("\($0)")
//                }
//            } currentValueLabel: {
//                Text("\(selectedMonth)월")
//            }
//        }
//    }
//}

