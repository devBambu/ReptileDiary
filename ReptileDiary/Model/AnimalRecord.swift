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
    var detailSpecies: String
    
    var name: String
    var gender: String
    
    var weight: Double?
    var birthday: Date?
//    var father: AnimalRecord?
//    var mother: AnimalRecord?
    
    var feeding: [String]
    
//    var records: [Date: DailyRecord?]
    
    var dailyFeed: [Date: DailyRecord<String>] = [:]
    var dailyWeight: [Date: DailyRecord<Double>] = [:]
    var dailyNote: [Date: DailyRecord<String>] = [:]
    var dailyMate: [Date: DailyRecord<String>] = [:]
    var dailyHospital: [Date: DailyRecord<String>] = [:]
    
    init(species: String, detailSpecies: String, name: String, gender: String, weight: Double? = nil, birthday: Date? = nil, feeding: [String], date: Date ) {
        self.species = species
        self.detailSpecies = detailSpecies
        self.name = name
        self.gender = gender
        self.weight = weight
        self.birthday = birthday
        self.feeding = feeding
        
        if weight != nil { self.dailyWeight = [date: DailyRecord(did: true, content: weight!)]}
//        self.records = weight == nil ? [date: nil] : [date: DailyRecord()]
    }
}

struct DailyRecord<D: Codable>: Codable {
//    var didFed: Bool = false
//    var food: String?
//    var weight: Double?
//    var didMate: Bool = false
//    var note: String?
//    var seeDoctor: Bool = false
    
    var did: Bool
    var content: D
}
