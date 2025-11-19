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
    @Attribute(.unique) var id: UUID
    var name: String
    var sex: String
    var weight: Float
    
    init(name: String, sex: String, weight: Float) {
        self.id = UUID()
        self.name = name
        self.sex = sex
        self.weight = weight
    }
}
