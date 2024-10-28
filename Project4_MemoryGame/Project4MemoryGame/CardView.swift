//
//  CardView.swift
//  Project4MemoryGame
//
//  Created by Administrator on 10/27/24.
//

import SwiftUI


struct CardModel {
    var id: Int
    var content: Image
    var isFaceUp: Bool = false
}


struct CardView: Identifiable, View {
    var id: Int

    var model: CardModel

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .shadow(radius: 10)
                .frame(width: 100, height: 150)


            Text(model.content)
                .font(.largeTitle)
                .foregroundColor(.white)
        }

    }
}

#Preview {

    var cm = CardModel(id: 1, content: Image(systemName: "heart.fill"), isFaceUp: false)

    CardView(id: 0, model: cm)
}
