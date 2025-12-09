//
//  FeedingView.swift
//  ReptileDiary
//
//  Created by 변예린 on 12/4/25.
//

import SwiftUI
import SwiftData

struct FeedingView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    var animal: AnimalRecord
    
    @State var isShowing: Bool = false
    @State var date: Date = Date()
    
    
    var body: some View {
        ZStack {
            List {
                Section {
                    HStack(spacing: 10) {
                        Spacer()
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                        Text("추가하기").font(.system(size: 20))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation(.snappy(duration: 0.25)) {
                            isShowing.toggle()
                        }
                    }
                    
                }
                Section {
                    ForEach(0..<animal.dailyFeed.count) { idx in
                        let key = Array(animal.dailyFeed.keys)[idx]
                        Text("\(key) : \(animal.dailyFeed[key])")
                    }
                }
            }
            if isShowing { feedingPopupView(isShowing: $isShowing, date: $date) }
            
        }
    }
}

#Preview {
    let dateManager = DateManager.shared
    FeedingView(animal: AnimalRecord(species: "도마뱀", detailSpecies: "크레스티드 게코", name: "짜코", gender: "여자", weight: 20, birthday: dateManager.getDate(year: 2024, month: 1, day: 1), feeding: [], date: dateManager.getDate(year: 2025, month: 12, day: 2)))
}

struct feedingPopupView: View {
    @Binding var isShowing: Bool
    @Binding var date: Date
    @State var year: Int = 2025
    @State var month: Int = 12
    @State var day: Int = 5
    
    @State var calendarIsShowing: Bool = false
    
    let dateManager = DateManager.shared
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.black)
                .opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture { isShowing.toggle() }
            
            Rectangle()
                .frame(width: .infinity, height: UIScreen.main.bounds.height * 0.6)
                .foregroundStyle(.white)
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                HStack {
                    Text("\(getDateString(date))")
                    Button {
                        calendarIsShowing.toggle()
                    } label: {
                        Image(systemName: "calendar")
                    }
                }
                if calendarIsShowing {
                    DatePicker("날짜", selection: $date, in: dateManager.getDateRange(),
                               displayedComponents: .date)
                    .labelsHidden()
                    .environment(\.timeZone, TimeZone(identifier: "Asia/Seoul")!)
                    .environment(\.locale, Locale(identifier: "ko"))
                        
                    
                    Button("확인") {
                        calendarIsShowing.toggle()
                    }
                }
                
            }
            .frame(width: .infinity, height: UIScreen.main.bounds.height * 0.5)
        }
        
    }
    
    func getDateString(_ date: Date) -> String {
        let origin = dateManager.getDate(of: date)
        return dateManager.dateFormat(origin)
    }
    
    
}
