//
//  NEW_GPApp.swift
//  NEW_GP
//
//  Created by 朝陽資管 on 2023/8/30.
//

import SwiftUI
import FirebaseCore

@main

struct NEW_GPApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("colorScheme") private var colorScheme: Bool = true
    init()
    {
        FirebaseApp.configure()
        // 執行移除 "colorScheme" 鍵的操作
        UserDefaults.standard.removeObject(forKey: "colorScheme")
    }
    var body: some Scene {
        WindowGroup {
            SiginView()
                .preferredColorScheme(self.colorScheme ? .light:.dark)
//            DataBaseExample()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
