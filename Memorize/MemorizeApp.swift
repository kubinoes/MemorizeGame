//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Jakub Schovanec on 27/05/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            GameView(viewModel: game)
        }
    }
}
