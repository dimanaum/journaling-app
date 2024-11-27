//
//  MainTabView.swift
//  JournalApp
//
//  Created by Dmitriy Naumenko on 11/26/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView() // Existing journal list
                .tabItem {
                    Label("Journals", systemImage: "book")
                }

            Text("Stats Section") // Placeholder for future section
                .tabItem {
                    Label("AI", systemImage: "chart.bar")
                }

            SettingsView() // Placeholder for settings
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
