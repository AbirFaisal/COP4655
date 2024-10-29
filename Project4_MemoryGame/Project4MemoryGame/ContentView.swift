//
//  ContentView.swift
//  Project4MemoryGame
//
//  Created by Administrator on 10/27/24.
//

import SwiftUI


//ContentModel


//ContentViewModel



struct ContentView: View {


//    @State private var cards = [CardView]()

    @State var cards: [CardModel] = []

    @State private var selectedSize: Int = 6

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]


    init() {
//        for index in 0..<11 {
//            let cm = CardModel()
//             self.cards.append(cm)
//         }
    }


    var body: some View {


        //UI Controls
        VStack {
            HStack {
                Picker("Choose Size", selection: $selectedSize) {
                    Text("Size 3").tag(3)
                    Text("Size 6").tag(6)
                    Text("Size 10").tag(10)
                }.onChange(of: self.selectedSize) { newValue in

                    cards = []
                    for index in 0..<newValue {
                        let cm = CardModel(id: index)
                        self.cards.append(cm)
                    }

                    print("New Value: \(newValue) \(cards.count)")

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
                            .onTapGesture {
                                    print("Card Tapped: \(card)")
                                }
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
