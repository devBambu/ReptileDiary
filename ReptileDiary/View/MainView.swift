//
//  MainView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/10/25.
//

import SwiftUI

struct MainView: View {
    let dateManager = DateManager.shared
    
    @State private var presentSideMenu = false
    @State private var presentSheet = false
    
    @State private var selectedYear: Int = 2025
    @State private var selectedMonth: Int = 11
    @State var selectedDate: Date = Date()
    
    
    var body: some View {

        ZStack {
            TabView {
                Tab("Calendar", systemImage: "calendar") {
                    VStack{
                        HStack {
                            Spacer()
                            Image(systemName: "lizard.fill")
                            Text("마뱀일기")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            Button {
                                presentSideMenu.toggle()
                            } label: {
                                Image(systemName: "text.justify")
                            }
                            .foregroundStyle(.gray)

                            Spacer()
                        }
                        
                        YearMonthPicker(year: $selectedYear, month: $selectedMonth, dateManager: dateManager)
                        CalendarGrid(dateManager: dateManager, year: selectedYear, month: selectedMonth, selectedDate: $selectedDate)
                        
                        Divider().background(Color.red)
                        
                        Spacer(minLength: 30)
                        BottomSheet(dateManager: dateManager, date: selectedDate)
                    }
                }
                
                Tab("Animal", systemImage: "lizard.fill") {
                    AnimalView()
                }
                

            }
        }

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
            .accentColor(.black)
            
            
            Picker("Month", selection: $month) {
                ForEach(0..<12) {
                    Text("\($0 + 1)").tag($0 + 1)
                }
            } currentValueLabel: {
                Text("\(month)월")
            }
            .accentColor(.black)
        }
    }
}

struct CalendarGrid: View {
    let dateManager: DateManager
    
    let year: Int
    let month: Int

    @Binding var selectedDate: Date
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let weekday = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        VStack(spacing: 0) {
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(0..<7) { idx in
                    Text(weekday[idx])
                        .font(.headline)
                        .foregroundColor(weekday[idx] == "일" ? .red : weekday[idx] == "토" ? .blue: .black)
                }
                .frame(width: 40, height: 40)
                .padding(1)
                .background(Color.white)
            }
            .frame(width: 330)
            
            LazyVGrid(columns: columns, spacing: 5) {
                let last = dateManager.getLastDay(of: month)
                let range = dateManager.getRange(year: year, month: month)
                let gap = range - last
                ForEach(0..<range) { idx in
                    if idx < gap {
                        Text("")
                    } else {
                        let num = idx - gap + 1
                    
                        Button("\(num)") {
                            if let date = dateManager.calendar.date(from: DateComponents(year: year, month: month, day: num)) {
                                selectedDate = date
                            }
                        }
                        .foregroundStyle(idx % 7 == 5 ? .blue : idx % 7 == 6 ? .red :.black)
                    }
                }
                .frame(width: 40, height: 40)
                .padding(1)
                .background(Color.white)
            }
            .id(month)
            .frame(width: 330, height: 300)
            .padding(.top, -35)
        }
    }
}

struct BottomSheet: View {
    let dateManager: DateManager
    let date: Date
    
    var body: some View {
        VStack {
            Text(dateManager.dateFormat(date))
                .fontWeight(.medium)
                .font(.system(size: 18))
            List {
                Image(systemName: "fork.knife.circle")
            }
            .background(Color.white)
        }
    }
    
}
