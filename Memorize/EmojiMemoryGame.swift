// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let vehicleEmojis =
    ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚",
     "🚛","🛴","🚲","🛵","🚜","🏍","🛺","🚡","🚃","✈️","🚀","🚁"]
    
    static let vehicleTheme = GameTheme(name: "Vehicles",
                                        emojis: vehicleEmojis,
                                        numOfPairs: 12,
                                        themeColor: "red")
    
    static let animalEmojis =
    ["🐶", "🐱", "🐭", "🐹", "🐙", "🐰", "🦊", "🐻", "🐼", "🐬",
     "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐦", "🐴", "🐍"]
    
    static let animalTheme = GameTheme(name: "Animals",
                                       emojis: animalEmojis,
                                       numOfPairs: 10,
                                       themeColor: "green")
    
    static let flagEmojis =
    ["🏳️‍🌈", "🏳️‍⚧️", "🇨🇦", "🇧🇷", "🇫🇷", "🇯🇵", "🇬🇧", "🇺🇸",
     "🇰🇷", "🇪🇸", "🇹🇭", "🇹🇷", "🇮🇹", "🇩🇪", "🇿🇦", "🇮🇳"]
    
    static let flagTheme = GameTheme(name: "Flags",
                                     emojis: flagEmojis,
                                     numOfPairs: 16,
                                     themeColor: "blue")
    
    static let halloweenEmojis =
    ["🔮","🐈‍⬛","🕸","🕷","🎃","👻","💀","😈"]
    
    static let halloweenTheme = GameTheme(name: "Halloween",
                                          emojis: halloweenEmojis,
                                          numOfPairs: 6,
                                          themeColor: "orange")
    
    static let fruitEmojis =
    ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓",
     "🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝"]
    
    static let fruitTheme = GameTheme(name: "Fruits",
                                      emojis: fruitEmojis,
                                      numOfPairs: 12,
                                      themeColor: "yellow")
    
    static let sportEmojis =
    ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏓","🥍","🏒"]
    
    static let sportTheme = GameTheme(name: "Sports",
                                      emojis: sportEmojis,
                                      numOfPairs: 10,
                                      themeColor: "red")
    
    static let allThemes = [vehicleTheme, animalTheme,
                            flagTheme, halloweenTheme,
                            fruitTheme, sportTheme]
    
    static let defaultTheme = GameTheme(name: "Default",
                                        emojis: ["❓"],
                                        numOfPairs: 1,
                                        themeColor: "blue")
    
    @Published private(set) var theme: GameTheme
    @Published private var model: MemoryGame<String>
    
    
    init() {
        let randomTheme = EmojiMemoryGame.selectRandomTheme()
        self.theme = randomTheme
        self.model = EmojiMemoryGame.createMemoryGame(randomTheme)
    }
    
    static func selectRandomTheme() -> GameTheme {
        if let randomTheme = allThemes.randomElement() {
            return randomTheme
        } else {
            return defaultTheme
        }
    }
    
    static func createMemoryGame(_ gameTheme: GameTheme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: gameTheme.numOfPairs) {
            pairIndex in gameTheme.emojis[pairIndex]
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
    
    func interpretThemeColor() -> Color {
        let chosenColor = theme.themeColor
        var displayColor: Color
        switch chosenColor {
        case "red":
            displayColor = Color(.systemRed)
        case "blue":
            displayColor = Color(.systemBlue)
        case "yellow":
            displayColor = Color(.systemYellow)
        case "green":
            displayColor = Color(.systemGreen)
        case "orange":
            displayColor = Color(.systemOrange)
        default:
            displayColor = Color(.systemGray)
        }
        return displayColor
    }
    
    func reinitialiseGame() {
        let randomTheme = EmojiMemoryGame.selectRandomTheme()
        self.theme = randomTheme
        self.model = EmojiMemoryGame.createMemoryGame(randomTheme)
    }
    
    func getScore() -> Int {
        return self.model.score
    }
}
