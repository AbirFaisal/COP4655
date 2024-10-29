//
//  CardView.swift
//  Project4MemoryGame
//
//  Created by Administrator on 10/27/24.
//

import SwiftUI


struct CardView: Identifiable, View {
    var id: Int

    @ObservedObject var model: CardModel


    var action: (() -> Void)?
    private func performAction() {
        action!()
    }


    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .shadow(radius: 10)
                .frame(width: 120, height: 200)
                .onTapGesture {
                    withAnimation {
                        model.isFaceUp.toggle()
                    }
                    performAction()
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
        .rotation3DEffect(
            .degrees(model.isFaceUp ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .opacity(model.isMatched ? 0 : 1)

    }

}

#Preview {

    var cm = CardModel(id:0)

    CardView(id: 0, model: cm, action: {})
}
