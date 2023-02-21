//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Jakub Schovanec on 27/05/2022.
//
 
import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("\(game.theme.name)").foregroundColor(game.getThemeColor()).font(.largeTitle)
            Text("Score: \(game.score)").foregroundColor(game.getThemeColor()).font(.largeTitle)
            AspectVGrid(items: game.cards, aspectRatio: DrawingConstants.cardAspectRatio) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            .foregroundColor(game.getThemeColor())
            .padding()
            Spacer()
            Button(action: {game.playAgain()}, label: {Text("New Game").font(.largeTitle).foregroundColor(game.getThemeColor())})
        }
    }
    
    private struct DrawingConstants {
        static let cardAspectRatio: CGFloat = 2/3
    }
}


    
struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).opacity(0.5).padding(5)
                Text(card.content).font(font(in: geometry.size))
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
    }
}














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .previewDevice("iPhone 12 mini")
            .preferredColorScheme(.light)
    }
}
