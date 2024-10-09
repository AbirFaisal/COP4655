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
    
    @State private var createCardViewPresented = false
    
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
                    onSwipedLeft: {
                        let removedCard = cards.remove(at: index)
                        cardsToPractice.append(removedCard)
                    },
                    onSwipedRight: {
                        let removedCard = cards.remove(at: index)
                        cardsMemorized.append(removedCard)

                    }
                )
                
                    .rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))
            }
        }
        .animation(.bouncy, value: cards)
        .id(deckId)
        
        .sheet(isPresented: $createCardViewPresented, content: {
            Text("")
            Text("Abir Faisal")
            Text("Z")
            
            CreateFlashcardView { card in
                cards.append(card)
            }
            
            

        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) { // <-- Add an overlay modifier with top trailing alignment for its contents
            Button("Add Flashcard", systemImage: "plus") {  // <-- Add a button to add a flashcard
                createCardViewPresented.toggle() // <-- Toggle the createCardViewPresented value to trigger the sheet to show
            }
        }
        
    }
}

#Preview {
    ContentView()
}
