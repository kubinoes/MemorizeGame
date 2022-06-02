//
//  ContentView.swift
//  Memorize
//
//  Created by Jakub Schovanec on 27/05/2022.
//
 
import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
            }
        }
        .foregroundColor(.red)
        .padding()
    }
}
    
struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                Text(card.content).font(.largeTitle)
                shape.strokeBorder(lineWidth: 3)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        GameView(viewModel: game)
            .previewDevice("iPhone 12 mini")
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeLeft)
        GameView(viewModel: game)
            .previewDevice("iPhone 12 mini")
            .preferredColorScheme(.light)
    }
}
