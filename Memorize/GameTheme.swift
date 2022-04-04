// Model

import Foundation

struct GameTheme {
    let name: String
    let emojis: [String]
    let numOfPairs: Int
    let themeColor: String
    
    init(name: String, emojis: [String], numOfPairs: Int, themeColor: String) {
        self.name = name
        self.emojis = emojis.shuffled()
        if emojis.count < numOfPairs {
            self.numOfPairs = emojis.count
        } else { self.numOfPairs = numOfPairs }
        self.themeColor = themeColor
    }
    
}
