//
//  PreviewRecord.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/20/25.
//

import Foundation
import SwiftData

@Model
class PreviewRecord { // 모델을 만들어내는 설계도(=스키마), 클래스의 인스턴스가 실제 모델에 해당
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var gender: String
    var weight: Float
    
    init(name: String , gender: String, weight: Float = 0.0) {
        self.name = name
        self.gender = gender
        self.weight = weight
    }
}
