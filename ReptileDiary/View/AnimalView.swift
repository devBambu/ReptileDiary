//
//  AnimalView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/22/25.
//

import SwiftUI

struct AnimalView: View {
    var animal: AnimalRecord
    var dateManager = DateManager.shared
    
    var body: some View {
        Spacer(minLength: 30)
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 5) {
                Image(systemName: "lizard.fill")
                Text(animal.name)
                    .font(.system(size: 20, weight: .bold))
                Text(animal.gender == "여자" ? "♀︎" : animal.gender == "남자" ? "♂︎" : "?")
                    .fontWeight(.bold)
                Text(animal.detailSpecies)
                    .font(.system(size: 15))
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .padding(.trailing, 30)
                    .foregroundStyle(.gray.opacity(0.1))
                    .frame(height: 70)
                HStack(alignment: .center, spacing: 15){
                    HStack {
                        Text("나이").fontWeight(.bold)
                        Text(animal.birthday == nil ? "모르겠어요!" : getAge(birthday: animal.birthday!))
                    }
                    HStack {
                        Text("무게").fontWeight(.bold)
                        Text(animal.weight == nil ? "모르겠어요!" : "\(animal.weight!)" + "g")
                    }
                    Spacer()
                }.padding(.leading, 30)
            }
        }.padding(.leading, 30)
        
        List {
            ForEach(0..<5) { idx in
                NavigationLink {
                    switch Category().mangeViews[idx].view {
                    case .feeding :
                        FeedingView(animal: animal)
                    case .weight :
                        InfoView(isEditing: false)
                    case .mating :
                        InfoView(isEditing: false)
                    case .note :
                        InfoView(isEditing: false)
                    case .hospital :
                        InfoView(isEditing: false)
                    }
                } label: {
                    Image(systemName: Category().mangeViews[idx].icon)
                        .resizable()
                        .frame(width: 35, height: 35)
                    Text(getLatestRecordView(of: Category().mangeViews[idx].view))
                        .padding(.leading, 10)
                }
            }
            .frame(height: 70)
        }
        .padding(.trailing, 30)
        .scrollContentBackground(.hidden)
        
    }
    
    func getLatestRecordDate<D>(record: [Date: DailyRecord<D>]) -> Date? {
        return record.isEmpty ? nil : record.keys.sorted(by: >)[0]
    }
    
    func getLatestRecordView(of view: ManageView) -> String {
        switch view {
        case .feeding :
            if let key = getLatestRecordDate(record: animal.dailyFeed) {
                let days = getDays(date: key)
                return "\(days)일 전 \(animal.dailyFeed[key]?.content)를 먹었어요."
            } else {
                return "작성된 기록이 없어요."
            }
        case .weight :
            if let key = getLatestRecordDate(record: animal.dailyFeed) {
                let days = getDays(date: key)
                return "\(days)일 전 \(animal.dailyWeight[key]?.content)g이었어요."
            } else {
                return "작성된 기록이 없어요."
            }
        case .mating :
            if let key = getLatestRecordDate(record: animal.dailyFeed) {
                let days = getDays(date: key)
                return "\(days)일 전 \(animal.dailyMate[key]?.content)와(과) 메이팅 했어요."
            } else {
                return "작성된 기록이 없어요."
            }
        case .note :
            if let key = getLatestRecordDate(record: animal.dailyFeed) {
                let days = getDays(date: key)
                return "\(animal.dailyNote[key]?.content), \(days)일 전"
            } else {
                return "작성된 기록이 없어요."
            }
        case .hospital :
            if let key = getLatestRecordDate(record: animal.dailyFeed) {
                let days = getDays(date: key)
                return "\(animal.dailyHospital[key]?.content), \(days)일 전"
            } else {
                return "작성된 기록이 없어요."
            }
        }
    }
       
    func getAge(birthday: Date) -> String {
        let today = dateManager.getDate()
        let components = dateManager.calendar.dateComponents([.year, .month], from: birthday, to: today)
        let years = components.year ?? 0
        let months = components.month ?? 0
        
        return years > 0 ? "\(years) 살 \(months) 개월" : "\(months) 개월"
    }
    
    func getDays(date: Date) -> Int {
        let today = dateManager.getDate()
        let components = dateManager.calendar.dateComponents([.day], from: date, to: today)
        return components.day ?? 0
    }
}

#Preview {
    let dateManager = DateManager.shared
    AnimalView(animal: AnimalRecord(species: "도마뱀", detailSpecies: "크레스티드 게코", name: "짜코", gender: "여자", weight: 20, birthday: dateManager.getDate(year: 2024, month: 1, day: 1), feeding: [], date: dateManager.getDate(year: 2025, month: 12, day: 2)))
}
