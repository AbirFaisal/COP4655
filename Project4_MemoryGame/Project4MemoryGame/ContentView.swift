//
//  ContentView.swift
//  Project4MemoryGame
//
//  Created by Administrator on 10/27/24.
//

import SwiftUI



struct ContentView: View {

    @State var cards: [CardModel] = []
    @State private var selectedSize: Int = 6

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    func checkGameState() {
        print("Checking Game State")

        var flippedCardIDs: [Int] = []

        //Check which cards are flipped
        for card in cards {
            if card.isFaceUp {
                if card.isMatched == false {
                    flippedCardIDs.append(card.id)
                }
            }
        }

        //Check if flipped cards match
        if flippedCardIDs.count == 2 {
            let id0 = flippedCardIDs[0]
            let id1 = flippedCardIDs[1]
            
            if cards[id0].content == cards[id1].content {
                print("Match Found")
                cards[id0].isMatched.toggle()
                cards[id1].isMatched.toggle()
            } else {
                print("No Match")
                cards[id0].isFaceUp.toggle()
                cards[id1].isFaceUp.toggle()
            }
        }


    }

    func resetGame() {
        print("Resetting Game")
        cards = []
        for index in 0..<selectedSize {
            let cm = CardModel(id: index)
            self.cards.append(cm)
        }
    }

    init() {
    }

    var body: some View {


        //UI Controls
        VStack {
            HStack {
                Picker("Choose Size", selection: $selectedSize) {
                    Text("Size 3").tag(3)
                    Text("Size 6").tag(6)
                    Text("Size 10").tag(10)
                }.onChange(of: self.selectedSize) {
                    resetGame()
                    print("New Value: \(selectedSize) \(cards.count)")
                }

                Spacer()
                Button("Reset Game") {
                    resetGame()
                }
            }

            //Game Area
            ScrollView {
                LazyVGrid(columns: columns) {

                    ForEach(cards, id: \.id) { card in
                        CardView(id: card.id, model: card) {
                            print("Card with id \(card.id) was tapped")
                            checkGameState()
                        }
                    }
                }

            }.onTapGesture {
                print("Card Tapped")
            }

        }
        .padding()
        .onAppear(perform: resetGame)

    }
}


#Preview {
    ContentView()
}
