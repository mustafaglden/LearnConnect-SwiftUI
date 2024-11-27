//
//  LearnConnect_SwiftUIApp.swift
//  LearnConnect-SwiftUI
//
//  Created by Mustafa on 28.11.2024.
//

import SwiftUI

@main
struct LearnConnect_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
