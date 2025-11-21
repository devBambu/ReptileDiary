//
//  MainView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/10/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        ZStack {
            TabView {
                Tab("Calendar", systemImage: "calendar") {
                    CalendarView()
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
        .modelContainer(.preview)
}
