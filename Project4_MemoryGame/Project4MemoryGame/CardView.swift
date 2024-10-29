//
//  CardView.swift
//  Project4MemoryGame
//
//  Created by Administrator on 10/27/24.
//

import SwiftUI


class CardModel: ObservableObject {
    var id: Int = 0

    var content: String = {
        let possibleEmojis = ["🎉","🍎","🌸","🚗","🔔","🏈","🍕","🌎","🦄"]

        return possibleEmojis.randomElement()!
    }()


    @Published var isFaceUp: Bool = false
    var defaultContent = Image(systemName: "questionmark")
}


struct CardView: Identifiable, View {
    var id: Int

    @ObservedObject var model: CardModel

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .shadow(radius: 10)
                .frame(width: 100, height: 150)
                .onTapGesture {
                    model.isFaceUp.toggle()
                }

            if model.isFaceUp {
                Text(model.content)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            else {
                Text(model.defaultContent)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }

    }

}

#Preview {

    var cm = CardModel()

    CardView(id: 0, model: cm)
}
