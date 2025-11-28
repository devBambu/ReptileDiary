//
//  AnimalRecord.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/19/25.
//

import Foundation
import SwiftData

@Model
class AnimalRecord { // 모델을 만들어내는 설계도(=스키마), 클래스의 인스턴스가 실제 모델에 해당
    @Attribute(.unique) var id: UUID = UUID()
    var species: String
    var name: String
    var gender: String
    
    var weight: Float?
    var birthday: Date?
//    var father: AnimalRecord?
//    var mother: AnimalRecord?
    
    var feeding: Int?
    
    init(species: String, name: String, gender: String, weight: Float? = nil, birthday: Date? = nil, feeding: Int? = nil) {
        self.species = species
        self.name = name
        self.gender = gender
        self.weight = weight
        self.birthday = birthday
        self.feeding = feeding
    }
}
