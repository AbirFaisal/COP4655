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


    @State private var cards = [CardView]()
    @State var selectedSize: Int = 6

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]


    init() {
        for index in 0..<selectedSize {
            let cm = CardModel(id: index, content: Image(systemName: "heart.fill"))

            let cv = CardView(id: index, model: cm)
             self.cards.append(cv)
         }

    }





    var body: some View {


        //UI Controls
        VStack {
            HStack {
                Picker("Choose Size", selection: $selectedSize) {
                    Text("Size 3").tag(3)
                    Text("Size 6").tag(6)
                    Text("Size 10").tag(10)
                }.onChange(of: selectedSize) { newValue in
                    print("New Value: \(newValue)")
                    //TODO reset game with new value
                }

                Spacer()
                Button("Reset Game") {
                }
            }

            //Game Area
            ScrollView {

                LazyVGrid(columns: columns) {

                    ForEach(0..<6) { index in
                        let cm = CardModel(id: index, content: Image(systemName: "heart.fill"))
                        CardView(id: index, model: cm)
                    }


//                    ForEach(cards) { card in
//                        Text("hello")
//                    }
                }
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
