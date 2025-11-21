//
//  AnimalView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/17/25.


import SwiftUI
import SwiftData

// 변수 타입 나중에 바꾸기
struct AnimalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var animals: [AnimalRecord]
    
    var body: some View {
        NavigationStack {
            List(animals) { animal in
                HStack{
                    NavigationLink(destination: InfoView(animal: animal, isEditing: false)) {
                        Image(systemName: "lizard.fill")
                        Text(animal.name)
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
    AnimalView()
        .modelContainer(.preview)
}

struct InfoView: View {
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Query private var animals: [AnimalRecord]
    
    @State private var name = ""
    @State private var gender = ""
    @State private var weight = "0"
    
    var animal: AnimalRecord?
    var isEditing: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "lizard.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            Spacer()
        }
        VStack {
            infoTf(info: "이름", text: $name, isEditing: isEditing, currentInfo: animal?.name)
            infoButtons(info: "성별", text: $gender, isEditing: isEditing, currentSelection: animal?.gender)
            infoTf(info: "무게", text: $weight, isEditing: isEditing, currentInfo: String(animal?.weight ?? 0))
            HStack {
                Spacer()
                Button("확인") {
                    guard let weight = Float(weight) else {
                        print("유효하지 않은 무게")
                        return
                    }
                    if let animal = animal {
                        update(of: animal, name: name, gender: gender, weight: weight)
                    } else {
                        insert(name: name, gender: gender, weight: weight)
                    }
                }
                Spacer()
            }
        }
        
    }
    
    func insert(name: String, gender: String, weight: Float) {
        let newAnimal = AnimalRecord(name: name, gender: gender, weight: weight)
        modelContext.insert(newAnimal)
        do { try modelContext.save() }
        catch { print("저장 실패: \(error)")}
        print("저장완료")
    }
    
    func update(of animal: AnimalRecord, name: String, gender: String, weight: Float) {
        guard let idx = animals.firstIndex(of: animal) else { return }
        animals[idx].name = name
        animals[idx].gender = gender
        animals[idx].weight = weight
        try? modelContext.save()
    }
    
    struct infoTf: View {
        let info: String
        @Binding var text: String
        
        let isEditing: Bool
        let currentInfo: String?
        
        var body: some View {
            HStack{
                Text(info)
                if let current = currentInfo {
                    TextField("\(current)", text: $text)
                        .disabled(isEditing ? false : true)
                        .tint(.black)
                } else {
                    TextField("\(info)를 입력해주세요.", text: $text)
                }
            }
        }
    }
    
    struct infoButtons: View {
        let info: String
        @Binding var text: String
        
        let isEditing: Bool
        //        let currentInfo: String?
        
        @State var currentSelection: String?
        
        var body: some View {
            VStack {
                Text(info)
                HStack {
                    if let category = Category().categories[info] {
                        ForEach(category, id: \.self) { c in
                            Button(c) {
                                text = c
                                currentSelection = c
                            }.disabled(isEditing ? false : true)
                                .background(currentSelection == c ? .green : .clear)
                        }
                    }
                }
            }
        }
    }
}

