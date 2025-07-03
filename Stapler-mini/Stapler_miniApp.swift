//
//  Stapler_miniApp.swift
//  Stapler-mini
//
//  Created by qdpb on 2024/10/27.
//

import SwiftData
import SwiftUI

@main
struct Stapler_miniApp: App {
    @StateObject var viewModel = ViewModel() // ViewModelを初期化
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
        .modelContainer(for: [Configuration.self], isUndoEnabled: true)
    }
}
