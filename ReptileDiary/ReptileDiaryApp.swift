//
//  ReptileDiaryApp.swift
//  ReptileDiary
//
//  Created by 변예린 on 11/10/25.
//

import SwiftUI
import SwiftData

@main
struct ReptileDiaryApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([AnimalRecord.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([PreviewRecord.self])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(sharedModelContainer)
        }
        
    }

}

extension ModelContainer {
    static var preview: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try! ModelContainer(for: AnimalRecord.self, configurations: config)
    }
}
