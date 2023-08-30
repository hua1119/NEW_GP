//
//  NEW_GPApp.swift
//  NEW_GP
//
//  Created by 朝陽資管 on 2023/8/30.
//

import SwiftUI

@main
struct NEW_GPApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
