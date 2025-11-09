//
//  Item.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/10/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
