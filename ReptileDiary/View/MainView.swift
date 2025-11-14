//
//  MainView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/10/25.
//

import SwiftUI

struct MainView: View {
    let dateManager = DateManager.shared
    
    @State private var selectedYear: Int = 2025
    @State private var selectedMonth: Int = 11
    
    var body: some View {
        HStack{
            Image(systemName: "lizard.fill")
            Text("마뱀일기")
                .font(.title)
                .fontWeight(.bold)
            
        }
        YearMonthPicker(year: $selectedYear, month: $selectedMonth, dateManager: dateManager)
        CalendarGrid(year: selectedYear, month: selectedMonth, dateManager: dateManager)
//        Form {
//            List {
//                HStack{
//                    Image(systemName: "fork.knife.circle")
//                    Text("이름")
//                }
//            }
//        }
    }
}

#Preview {
    MainView()
}

struct YearMonthPicker: View {
    @Binding var year: Int
    @Binding var month: Int
    
    let dateManager: DateManager
    
    var body: some View {
        HStack {
            Picker("Year", selection: $year) {
                let yearRange = dateManager.getYearRange()
                ForEach(0..<5) {
                    Text(yearRange[$0]).tag(yearRange[$0])
                }
            } currentValueLabel: {
                Text("\(String(format: "%04d", year))년")
            }
            
            Picker("Month", selection: $month) {
                ForEach(0..<12) {
                    Text("\($0 + 1)").tag($0 + 1)
                }
            } currentValueLabel: {
                Text("\(month)월")
            }
        }
    }
}

struct CalendarGrid: View {
    let year: Int
    let month: Int
    let dateManager: DateManager
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let weekday = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 5) {
            let last = dateManager.getLastDay(of: month)
            let range = dateManager.getRange(year: year, month: month)
            let gap = range - last
            ForEach(0..<(range + 7)) { idx in
                if idx < 7 {
                    Text(weekday[idx])
                        .font(.headline)
                        .foregroundColor(weekday[idx] == "일" ? Color.red : .black)
                } else if idx < gap + 7 {
                    Text("")
                } else {
                    Text("\(idx - gap - 6)")
                }
            }
            .frame(width: 40, height: 40)
            .padding(1)
            .background(Color.white)
        }
        .id(month)
        .frame(width: 330, height: 300)
    }
}

