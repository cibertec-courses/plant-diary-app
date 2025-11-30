//
//  plant_diary_appApp.swift
//  plant-diary-app
//
//  Created by DamII on 30/11/25.
//

import SwiftUI

@main
struct plant_diary_appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
