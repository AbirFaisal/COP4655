//
//  TriviaGameApp.swift
//  TriviaGame
//
//  Created by Administrator on 11/3/24.
//

import SwiftUI

@main
struct TriviaGameApp: App {
    var body: some Scene {
        WindowGroup {
            var model = ContentModel()

            ContentView(viewModel: ContentViewModel(model: model))
        }
    }
}
