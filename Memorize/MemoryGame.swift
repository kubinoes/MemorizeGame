//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jakub Schovanec on 30/05/2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ( $0 == newValue ) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            // check if a card is already face up
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // if previously selected card is the same as new then match and increase score
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else { // if not same, deduct point if card was already seen and mark as seen
                    cards[chosenIndex].wasSeen ? score -= 1 : nil
                    cards[potentialMatchIndex].wasSeen ? score -= 1 : nil
                    cards[chosenIndex].wasSeen = true
                    cards[potentialMatchIndex].wasSeen = true
                }
                // flip the selected card
                cards[chosenIndex].isFaceUp = true
            } else {
                // we are flipping a first card, put all cards face down
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var wasSeen = false
        let content: CardContent
        let id: Int
    }
}


extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
