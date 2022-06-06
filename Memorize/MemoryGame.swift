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
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
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
                // since we have two cards face up now, we have to restart the index of first selected card
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                // we are flipping a first card, put all cards face down
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                // save index of current card selection
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            // flip the selected card
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var wasSeen: Bool = false
    }
}
