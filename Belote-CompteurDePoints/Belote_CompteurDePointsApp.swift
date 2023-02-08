//
//  Belote_CompteurDePointsApp.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 08/02/2023.
//

import SwiftUI

@main
struct Belote_CompteurDePointsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
