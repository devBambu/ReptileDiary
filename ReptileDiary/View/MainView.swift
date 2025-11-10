//
//  MainView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/10/25.
//

import SwiftUI

struct MainView: View {
    @State private var selectedYear: String = "2025"
    @State private var selectedMonth: String = "11"
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        HStack {
            Picker("Year", selection: $selectedYear) {
                ForEach(Range<Int>(2000...2020)) {
                    Text("\($0)")
                }
            } currentValueLabel: {
                Text(selectedYear)
            }
            Picker("Month", selection: $selectedYear) {
                ForEach(Range<Int>(1...12)) {
                    Text("\($0)")
                }
            } currentValueLabel: {
                Text(selectedMonth)
            }
        }
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(Range(0...200)) {
                    Text("\($0)")
                }
                .frame(width: 40, height: 40)
                .padding(1)
                .background(Color.blue)
                
            }
        }
        .frame(width: 300, height: 300)
    }
}

#Preview {
    MainView()
}
