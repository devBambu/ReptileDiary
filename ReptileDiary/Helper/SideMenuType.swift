//
//  SideMenuType.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/15/25.
//

import Foundation
import SwiftUI

enum SideMenuRowType: Int, CaseIterable {
    
    case calendar
    case animal
    
    var title: String {
        switch self {
        case .calendar:
            return "Calendar"
        case .animal:
            return "Animal"
        }
    }
    
    var iconName: String {
        switch self {
        case .calendar:
            return "calendar"
        case .animal:
            return "lizard"
        }
    }
    
    var view: View {
        switch self {
        case .calendar:
            return MainView()
        case .animal:
            return AnimalListView()
        }
    }
}
