//
//  MainView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/10/25.
//

import SwiftUI

struct MainView: View {
    let dateManager = DateManager.shared
    
    @State var presentSideMenu: Bool = false
    
    @State private var selectedYear: Int = 2025
    @State private var selectedMonth: Int = 11
    
    var body: some View {
        ZStack {
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

                    Spacer()
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
            SideMenuView(isShowing: $presentSideMenu, content: AnyView(SideMenu()))
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

struct SideMenuView: View {
    @Binding var isShowing: Bool

    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .trailing)
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture { isShowing.toggle() }
                content
                    .transition(edgeTransition)
                    .background(Color.clear)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
    
}

struct SideMenu: View {
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                VStack(alignment: .trailing, spacing: 0) {
                    ForEach(SideMenuRowType.allCases, id: \.self) { row in
                        rowView(isSelected: true, imageName: row.iconName, title: row.title) {
                            print(row.title)
                        }
                    }
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(Color.white)
            }
        }
        .background(.clear)
    }
    
    func rowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (() -> ())) -> some View {
        Button {
            action()
        } label: {
            VStack(alignment: .trailing) {
                HStack(spacing: 20) {
                    Rectangle()
                        .fill(isSelected ? .purple : .white)
                        .frame(width: 5)
                    
                    ZStack {
                        Image(systemName: imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(LinearGradient(colors: [isSelected ? .purple.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing))

    }
}
