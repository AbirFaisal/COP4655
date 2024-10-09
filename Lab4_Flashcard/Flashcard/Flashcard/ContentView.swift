//
//  ContentView.swift
//  Flashcard
//
//  Created by Administrator on 10/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var cards: [Card] = Card.mockedCards
    
    @State private var cardsToPractice: [Card] = []
    @State private var cardsMemorized: [Card] = []
    
    @State private var deckId: Int = 0
    
    
    var body: some View {

        
        ZStack {
            
            VStack {
                Button("Reset") {
                    cards = cardsToPractice + cardsMemorized
                    cardsToPractice = []
                    cardsMemorized = []
                    deckId += 1
                }
                .disabled(cardsToPractice.isEmpty && cardsMemorized.isEmpty)
                
                
                Button("More Practice") {
                    cards = cardsToPractice
                    cardsToPractice = []
                    deckId += 1
                }
                .disabled(cardsToPractice.isEmpty)
            }
            
            
            ForEach(0..<cards.count, id: \.self) { index in

                CardView(
                    card: cards[index],
                    onSwipedLeft: { cards.remove(at: index) },
                    onSwipedRight: { cards.remove(at: index) }
                )
                
                    .rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))
            }
        }
        .animation(.bouncy, value: cards)
        .id(deckId)
        
        
    }
}

#Preview {
    ContentView()
}
