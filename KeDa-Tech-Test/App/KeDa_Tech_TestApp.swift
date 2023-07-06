//
//  KeDa_Tech_TestApp.swift
//  KeDa-Tech-Test
//
//  Created by Vincent on 06/07/23.
//

import SwiftUI

@main
struct KeDa_Tech_TestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
