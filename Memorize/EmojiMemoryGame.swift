//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jakub Schovanec on 30/05/2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let emojis = ["✈️", "🚀", "🚁", "🚜", "🚃", "🚗", "🚡", "🏎", "🛺", "🛳", "🚲", "🛴", "🚚", "🚔", "🏍", "🚑", "🚕", "⛵️", "🚒", "🚤", "🛵", "🚂", "🚐", "🛻"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
