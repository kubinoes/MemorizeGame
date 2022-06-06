//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Jakub Schovanec on 27/05/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
