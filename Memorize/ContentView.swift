import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
            ScrollView{
                HStack {
                    themeName
                    Spacer()
                    displayScore
                }.font(.title)
                
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 100))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
                Spacer()
                newGame
                Spacer()
            }
            .foregroundColor(viewModel.interpretThemeColor())
            .padding(.horizontal)
            .font(.largeTitle)
    }
    
    var themeName: some View {
        Text("Theme: \(viewModel.theme.name)")
    }
    
    var displayScore: some View {
        Text("Score: \(viewModel.getScore())")
    }
    
    var newGame: some View {
        Button(action: {
            viewModel.reinitialiseGame()
        },
               label: {
                Text("New Game")
        })
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 4)
                Text(card.content)
                    .font(.largeTitle)
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
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portrait)
    }
}
