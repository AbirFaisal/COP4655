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
        print("Checking Game State \(cards)")

        
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
