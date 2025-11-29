//
//  AnimalView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/22/25.
//

import SwiftUI

struct AnimalView: View {
    let animal: AnimalRecord
    
    var body: some View {
        HStack {
            Image(systemName: "lizard.fill")
                .padding(.leading, 30)
            Text(animal.name)
                .fontWeight(.bold)
            Spacer()
        }
        Text("오늘의 할 일!")
            .font(.headline)
        
    }
}

#Preview {
    AnimalView(animal: AnimalRecord(species: "도마뱀", name: "짜코", gender: "여자", feeding: []))
}
