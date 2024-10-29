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

    var body: some View {


        //UI Controls
        VStack {
            HStack {
                Picker("Choose Size", selection: $selectedSize) {
                    Text("Size 3").tag(3)
                    Text("Size 6").tag(6)
                    Text("Size 10").tag(10)
                }.onChange(of: self.selectedSize) {
                    cards = []
                    for index in 0..<selectedSize {
                        let cm = CardModel(id: index)
                        self.cards.append(cm)
                    }
                    print("New Value: \(selectedSize) \(cards.count)")
                }

                Spacer()
                Button("Reset Game") {
                    cards = []
                    for index in 0..<selectedSize {
                        let cm = CardModel(id: index)
                        self.cards.append(cm)
                    }
                }
            }

            //Game Area
            ScrollView {
                LazyVGrid(columns: columns) {

                    ForEach(cards, id: \.id) { card in
                        CardView(id: card.id, model: card)
                    }

                }
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
