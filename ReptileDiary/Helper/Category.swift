//
//  Untitled.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/21/25.
//

import Foundation
import SwiftUICore

struct Category {
    
    let categories = [
        "성별": ["여자", "남자", "미구분"],
        "분류": ["도마뱀", "뱀", "거북이", "양서류", "기타"],
        "피딩": ["월", "화", "수", "목", "금", "토", "일"]
    ]
    
    let mangeViews = [feeding, weight, mating, note, hospital]
}

struct ManageItem {
    let title: String
    let icon: String
    let view: ManageView
    
    init(title: String, icon: String, view: ManageView) {
        self.title = title
        self.icon = icon
        self.view = view
    }
}

let feeding = ManageItem(title: "피딩", icon: "fork.knife.circle", view: .feeding)
let weight = ManageItem(title: "무게", icon: "chart.xyaxis.line", view: .weight)
let mating = ManageItem(title: "메이팅", icon: "heart.circle", view: .mating)
let note = ManageItem(title: "특이사항", icon: "note.text", view: .note)
let hospital = ManageItem(title: "병원", icon: "cross.circle", view: .hospital)

enum ManageView {
    case feeding
    case weight
    case mating
    case note
    case hospital
}
