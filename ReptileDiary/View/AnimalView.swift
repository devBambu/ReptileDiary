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
                    Image(systemName: "lizard.fill")
                    Text(animal.name)
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
   
    @State private var name = ""
    @State private var sex = ""
    @State private var weight = "0"
    
    var body: some View {
        Form {
            Circle().frame(width: 80, height: 80)
            Section("기본 정보") {
                VStack {
                    HStack {
                        Text("이름: ")
                        TextField("이름", text: $name)
                    }
                    HStack {
                        Text("성별: ")
                        TextField("성별", text: $sex)
                    }
                    HStack {
                        Text("무게: ")
                        TextField("무게", text: $weight)
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
                    let newAnimal = AnimalRecord(name: name, sex: sex, weight: weight)
                    modelContext.insert(newAnimal)
                    do { try modelContext.save() }
                    catch { print("저장 실패: \(error)")}
                    print("확인완료")
                }
                Spacer()
            }
        }
        .background(.white)

    }
}
