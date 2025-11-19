//
//  AnimalView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/17/25.


import SwiftUI
import SwiftData

struct AnimalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var animals: [AnimalRecord]
    
    var body: some View {
        NavigationStack {
            List(animals) { animal in
                HStack{
                    NavigationLink(destination: AddView(animal: animal)) {
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
                    Button {
                        print("수정")
                    } label: {
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
                    NavigationLink(destination: AddView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            
        }

    }
}


#Preview {
    AnimalView()
        .modelContainer(for: [AnimalRecord.self])
}

struct AddView: View {

    @Environment(\.modelContext) private var modelContext: ModelContext
    @Query private var animals: [AnimalRecord]
   
    @State private var name = ""
    @State private var sex = ""
    @State private var weight = "0"
    
    var animal: AnimalRecord?
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                Image(systemName: "lizard.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                Spacer()
            }
            Section("기본 정보") { // 플레이스홀더 수정 필요
                    VStack {
                        HStack {
                            Text("이름: ")
                            TextField(animal?.name ?? "이름", text: $name)
                        }
                        HStack {
                            Text("성별: ")
                            TextField(animal?.sex ?? "성별", text: $sex)
                        }
                        HStack {
                            Text("무게: ")
                            TextField("\(animal?.weight)", text: $weight) // 수정 필요
                        }
                }
            }
            
            HStack {
                Spacer()
                Button("확인") {
                    guard let weight = Float(weight) else {
                        print("유효하지 않은 무게")
                        return
                    }
                    if let animal = animal {
                        update(of: animal, name: name, sex: sex, weight: weight)
                    } else {
                        insert(name: name, sex: sex, weight: weight)
                    }
                }
                Spacer()
            }
        }
        .scrollContentBackground(.hidden)

    }
    
    func insert(name: String, sex: String, weight: Float) {
        let newAnimal = AnimalRecord(name: name, sex: sex, weight: weight)
        modelContext.insert(newAnimal)
        do { try modelContext.save() }
        catch { print("저장 실패: \(error)")}
        print("확인완료")
    }
    
    func update(of animal: AnimalRecord, name: String, sex: String, weight: Float) {
        guard let idx = animals.firstIndex(of: animal) else { return }
        animals[idx].name = name
        animals[idx].sex = sex
        animals[idx].weight = weight
        try? modelContext.save()
    }
}
