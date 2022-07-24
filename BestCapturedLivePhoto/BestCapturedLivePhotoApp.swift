//
//  BestCapturedLivePhotoApp.swift
//  BestCapturedLivePhoto
//
//  Created by Furkan Erdoğan on 21.07.2022.
//

import SwiftUI

@main
struct BestCapturedLivePhotoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
