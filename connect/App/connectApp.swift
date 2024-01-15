//
//  connectApp.swift
//  connect
//
//  Created by Рауан Аблайхан on 05.01.2024.
//

import SwiftUI

@main
struct connectApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
