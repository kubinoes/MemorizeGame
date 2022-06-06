//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Jakub Schovanec on 03/06/2022.
//

import Foundation
import SwiftUI

struct EmojiTheme {
    var name: String
    var emojis: [String]
    private(set) var numberOfPairs: Int
    var color: String
    
    init(name: String, emojis: [String], numberOfPairs: Int, color: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairs = numberOfPairs > emojis.count ? emojis.count : numberOfPairs
        self.color = color
    }
}
