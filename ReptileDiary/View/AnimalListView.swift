//
//  AnimalView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/17/25.


import SwiftUI
import SwiftData

struct AnimalListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var animals: [AnimalRecord]
    
    var body: some View {
        NavigationStack {
            List(animals) { animal in
                HStack{
                    NavigationLink(destination: InfoView(animal: animal, isEditing: false)) {
                        Image(systemName: "lizard.fill")
                        Text(animal.name)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                        Text(animal.gender)
                            .font(.system(size: 13))
                    }
                }
                .frame(height: 50)
                
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        modelContext.delete(animal)
                    } label: {
                        Label("삭제", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    NavigationLink(destination: InfoView(animal: animal, isEditing: true)) {
                        Label("수정", systemImage: "pencil")
                    }
                    .tint(.blue)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("나의 식구들")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: InfoView(isEditing: true)) {
                        Image(systemName: "plus")
                    }
                }
            }
            
        }
        
    }
}


#Preview {
    AnimalListView()
        .modelContainer(.preview)
}
