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
    
    var dateManager = DateManager.shared
    
    @State private var species = ""
    @State private var detailSpeciese = ""
    @State private var name = ""
    @State private var gender = ""
    @State private var weight = ""
    @State private var birthday = Date()
    @State private var feeding: [String] = []
    
    @State var textWidth: CGFloat = 0
    
    @State private var knowBirthday: Bool = false
    
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
                    .padding(30)
                Spacer()
            }
        
            VStack(alignment: .leading, spacing: 15) {
                Text("기본 정보").font(.system(size: 20, weight: .bold))
                // 필수 입력
                infoButtons(info: "분류", text: $species, isEditing: isEditing, currentSelection: animal?.species)
                infoTf<String>(info: "종", text: $detailSpeciese, isEditing: isEditing, currentInfo: animal?.detailSpecies, textWidth: $textWidth)
                infoTf<String>(info: "이름", text: $name, isEditing: isEditing, currentInfo: animal?.name, textWidth: $textWidth)
                infoButtons(info: "성별", text: $gender, isEditing: isEditing, currentSelection: animal?.gender)
                
                // 선택 입력
                HStack{
                    Text("생일").bold()
                    DatePicker("생일", selection: $birthday, displayedComponents: [.date])
                        .labelsHidden()
                        .disabled(!knowBirthday)
                        .environment(\.timeZone, TimeZone(identifier: "Asia/Seoul")!)
                        .environment(\.locale, Locale(identifier: "ko"))
                    Button {
                        knowBirthday.toggle()
                    } label: {
                        Image(systemName: knowBirthday ? "square" : "checkmark.square")
                    }
                    Text("모르겠어요!")
                }
            }
            .padding(.leading, 30)
            .padding(.bottom, 25)
            .frame(maxWidth: .infinity, alignment: .leading)

            // 선택 입력
            VStack(alignment: .leading, spacing: 15) {
                Text("관리 정보").font(.system(size: 20, weight: .bold))
                HStack {
                    infoTf<Double>(info: "무게", text: $weight, isEditing: isEditing, currentInfo: animal?.weight, textWidth: $textWidth)
                    Text("g")
                }
                
                multipleInfoButtons(info: "피딩", text: $feeding, isEditing: isEditing, currentSelection: animal?.feeding)
            }
            .padding(.leading, 30)
            .padding(.bottom, 25)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {

                Button("확인") {
                    let dWeight = Double(weight)
                    if let animal = animal {
                        update(of: animal, species: species, detailSpecies: detailSpeciese, name: name, gender: gender, weight: dWeight, birthday: birthday, feeding: feeding)
                    } else {
                        insert(species: species, detailSpecies: detailSpeciese, name: name, gender: gender, weight: dWeight, birthday: birthday, feeding: feeding)
                    }
                }

            }

        
    }
    
    func insert(species: String, detailSpecies: String, name: String, gender: String, weight: Double?, birthday: Date, feeding: [String]) {
        let bDay = knowBirthday ? dateManager.getDate(of: birthday) : nil
        let today = dateManager.getDate()
        
        let newAnimal = AnimalRecord(species: species, detailSpecies: detailSpeciese, name: name, gender: gender, weight: weight, birthday: bDay, feeding: feeding, date: today)
        
        modelContext.insert(newAnimal)
        
        do { try modelContext.save() }
        catch { print("저장 실패: \(error)")}
        
        print("\(name) \(weight) 저장완료")
    }
    
    func update(of animal: AnimalRecord, species: String, detailSpecies: String, name: String, gender: String, weight: Double?, birthday: Date, feeding: [String]) {
        guard let idx = animals.firstIndex(of: animal) else { return }
        animals[idx].species = species
        animals[idx].name = name
        animals[idx].gender = gender
        animals[idx].weight = weight
        animals[idx].birthday = knowBirthday ? dateManager.getDate(of: birthday) : nil
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
    
    @Binding var textWidth: CGFloat
    
    var placeholder: String {
        if let current = currentInfo {
            return "\(current)"
        } else {
            return "\(info)을(를) 입력해주세요."
        }
    }
    
    var body: some View {
        HStack{
            Text(info).bold()
        
            TextField(placeholder, text: $text)
                .frame(width: info == "무게" ? textWidth : .infinity)
                .disabled(isEditing ? false : true)
                .tint(.black)
                .background {
                    if info == "무게" {
                        Text(text.isEmpty ? placeholder : text)
                            .fixedSize()
                            .hidden()
                            .onGeometryChange(for: CGFloat.self) { proxy in
                                proxy.size.width
                            } action: { newVal in
                                textWidth = newVal
                            }
                    }
                }
        }
    }
    
}

struct infoButtons: View {
    let info: String
    @Binding var text: String
    
    let isEditing: Bool
    let currentSelection: String?
    
    var body: some View {
        HStack {
            Text(info).bold()
            if let category = Category().categories[info] {
                ForEach(category, id: \.self) { c in
                    Button(c) {
                        text = c
                    }.disabled(isEditing ? false : true)
                        .background(text == c ? .green : .clear)
                }
            }
        }
    }
    
}

struct multipleInfoButtons: View {
    let info: String
    @Binding var text: [String]
    
    let isEditing: Bool
    let currentSelection: [String]?
    
    var body: some View {
        HStack {
            Text(info).bold()
            if let category = Category().categories[info] {
                ForEach(category, id: \.self) { c in
                    Button(c) {
                        if text.contains(c){
                            text.remove(at: text.firstIndex(of: c)!)
                        } else { text.append(c) }
                    }.disabled(isEditing ? false : true)
                        .background(text.contains(c) ? .green : .clear)
                }
            }
        }
    }
}
