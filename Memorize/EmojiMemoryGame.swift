//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jakub Schovanec on 30/05/2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let travelEmojis = ["✈️", "🚀", "🚁", "🚜", "🚃", "🚗", "🚡", "🏎", "🛺", "🛳", "🚲", "🛴", "🚚", "🚔", "🏍", "🚑", "🚕", "⛵️", "🚒", "🚤", "🛵", "🚂", "🚐", "🛻"]
    static let faceEmojis = ["😀", "🥹", "😂", "😎", "🥳", "🤩"]
    static let halloweenEmojis = ["🎃", "👹", "👺", "👽", "😱", "🦇", "☠️", "👻", "💀", "😈"]
    static let animalEmojis = ["🐰", "🦊", "🐻", "🐮", "🐷", "🐨"]
    static let ballEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐"]
    static let sportEmojis = ["💃", "⛷", "🏋️‍♀️", "🚴", "🏌️‍♀️", "🧗‍♀️", "🤽‍♀️"]
    
    static let availableThemes: [EmojiTheme] = [
        EmojiTheme(name: "Travel", emojis: travelEmojis, numberOfPairs: 6, color: "red"),
        EmojiTheme(name: "Faces", emojis: faceEmojis, numberOfPairs: 4, color: "blue"),
        EmojiTheme(name: "Halloween", emojis: halloweenEmojis, numberOfPairs: 8, color: "black"),
        EmojiTheme(name: "Animals", emojis: animalEmojis, numberOfPairs: 50, color: "pink"),
        EmojiTheme(name: "Balls", emojis: ballEmojis, numberOfPairs: 2, color: "purple"),
        EmojiTheme(name: "Sports", emojis: sportEmojis, numberOfPairs: 6, color: "yellow"),
    ]
    
    static func createMemoryGame(with theme: EmojiTheme) -> MemoryGame<String> {
        print(theme.emojis)
        let emojiSet = theme.emojis.shuffled()
        print(emojiSet)
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in emojiSet[pairIndex] }
    }
    
    @Published private var model: MemoryGame<String>
    private(set) var theme: EmojiTheme
    
    init() {
        theme = EmojiMemoryGame.availableThemes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    func getThemeColor() -> Color {
        switch theme.color {
            case "red": return .red
            case "blue": return .blue
            case "black": return .black
            case "pink": return .pink
            case "purple": return .purple
            case "yellow": return .yellow
            default: return .red
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func playAgain() {
        theme = EmojiMemoryGame.availableThemes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}
