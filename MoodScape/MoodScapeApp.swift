//
//  MoodScapeApp.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import SwiftUI
import RealmSwift

@main
struct MoodScapeApp: SwiftUI.App {  // Explicitly specify SwiftUI.App to avoid ambiguity
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: setupRealm)
        }
    }

    func setupRealm() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Perform migrations if needed
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
    }
}
