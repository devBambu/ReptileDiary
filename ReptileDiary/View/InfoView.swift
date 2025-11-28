//
//  InfoView.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/27/25.
//
import SwiftUI
import SwiftData

struct InfoView: View {
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Query private var animals: [AnimalRecord]
    
    @State private var species = ""
    @State private var name = ""
    @State private var gender = ""
    @State private var weight = ""
    @State private var birthday = Date()
    @State private var feeding: Int? = 1
    
    @State private var knowBirthday: Bool = true
    
    var animal: AnimalRecord?
    var isEditing: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "lizard.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding(30)
                Spacer()
            }
            VStack(alignment: .leading, spacing: 15) {
                Text("기본 정보").font(.system(size: 20, weight: .bold))
                // 필수 입력
                infoButtons(info: "분류", text: $species, isEditing: isEditing, currentSelection: animal?.species)
                infoTf<String>(info: "이름", text: $name, isEditing: isEditing, currentInfo: animal?.name)
                infoButtons(info: "성별", text: $gender, isEditing: isEditing, currentSelection: animal?.gender)
                
                // 선택 입력
                HStack{
                    Text("생일").bold()
                    DatePicker("생일", selection: $birthday, displayedComponents: [.date])
                        .labelsHidden()
                        .disabled(!knowBirthday)
                    Button {
                        knowBirthday.toggle()
                    } label: {
                        Image(systemName: knowBirthday ? "square" : "checkmark.square")
                    }
                    Text("모르겠어요!")
                }
            }
            .padding(.bottom, 25)
            
            // 선택 입력
            VStack(alignment: .leading, spacing: 15) {
                Text("관리 정보").font(.system(size: 20, weight: .bold))
                HStack {
                    infoTf<Double>(info: "무게", text: $weight, isEditing: isEditing, currentInfo: animal?.weight)
                    Text("g")
                }
                HStack {
                    Text("피딩 주기").bold()
                    Text("주")
                    Picker("피딩 주기", selection: $feeding) {
                        ForEach(1..<8) {
                            Text("\($0)").tag($0)
                        }
                    }
                    Text("회")
                    Spacer()
                }
            }
            .padding(.bottom, 25)
            
            HStack {
                Spacer()
                Button("확인") {
                    let dWeight = Double(weight)
                    if let animal = animal {
                        update(of: animal, species: species, name: name, gender: gender, weight: dWeight, birthday: birthday, feeding: feeding)
                    } else {
                        insert(species: species, name: name, gender: gender, weight: dWeight, birthday: birthday, feeding: feeding)
                    }
                }
                Spacer()
            }
        }
        .padding(30)
        
    }
    
    func insert(species: String, name: String, gender: String, weight: Double?, birthday: Date?, feeding: Int?) {
        let bDay = knowBirthday ? birthday : nil
        
        let newAnimal = AnimalRecord(species: species, name: name, gender: gender, weight: weight, birthday: bDay, feeding: feeding)
        modelContext.insert(newAnimal)
        do { try modelContext.save() }
        catch { print("저장 실패: \(error)")}
        print("\(name) \(weight) 저장완료")
    }
    
    func update(of animal: AnimalRecord, species: String, name: String, gender: String, weight: Double?, birthday: Date?, feeding: Int?) {
        guard let idx = animals.firstIndex(of: animal) else { return }
        animals[idx].species = species
        animals[idx].name = name
        animals[idx].gender = gender
        animals[idx].weight = weight
        animals[idx].birthday = birthday
        animals[idx].feeding = feeding
        try? modelContext.save()
    }
    
    
    
    
}

#Preview {
    InfoView(isEditing: true)
        .modelContainer(.preview)
}

struct infoTf<T>: View {
    let info: String
    @Binding var text: String
    
    let isEditing: Bool
    let currentInfo: T?
    
    var body: some View {
        HStack{
            Text(info).bold()
            if let current = currentInfo {
                TextField("\(current)", text: $text)
                    .disabled(isEditing ? false : true)
                    .tint(.black)
            } else {
                TextField("\(info)를 입력해주세요.", text: $text)
                    .frame(width: info == "무게" ? 50 : .infinity)
            }
        }
    }
}

struct infoButtons: View {
    let info: String
    @Binding var text: String
    
    let isEditing: Bool
    @State var currentSelection: String?
    
    var body: some View {
        HStack {
            Text(info).bold()
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
