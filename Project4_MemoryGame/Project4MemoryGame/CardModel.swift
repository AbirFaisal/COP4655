//
//  CardModel.swift
//  Project4MemoryGame
//
//  Created by Administrator on 10/27/24.
//

import SwiftUI


class CardModel: ObservableObject {

    var id: Int

    init(id: Int) {
        self.id = id
    }

    var content: String = {
        let possibleEmojis = ["🎉","🌸","🚗","🍕","🌎","🦄"]

        return possibleEmojis.randomElement()!
    }()


    @Published var isFaceUp: Bool = false
    
    @Published var isMatched: Bool = false

    var defaultContent = Image(systemName: "questionmark")
}
