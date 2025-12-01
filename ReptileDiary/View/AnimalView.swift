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
        Spacer(minLength: 30)
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "lizard.fill")
                Text(animal.name)
                    .fontWeight(.bold)
                Text(animal.gender == "여자" ? "♀︎" : animal.gender == "남자" ? "♂︎" : "?")
                    .fontWeight(.bold)
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
                        InfoView(isEditing: false)
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
                        
                }
            }
            .frame(height: 70)
        }
        .padding(.trailing, 30)
        .scrollContentBackground(.hidden)
        
    }
}

#Preview {
    AnimalView(animal: AnimalRecord(species: "도마뱀", name: "짜코", gender: "여자", weight: 20, feeding: []))
}
