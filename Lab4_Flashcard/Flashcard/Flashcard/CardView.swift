//
//  CardView.swift
//  Flashcard
//
//  Created by Administrator on 10/7/24.
//

import SwiftUI


struct Card: Equatable {
    let question: String
    let answer: String
    
    static let mockedCards = [
        Card(question: "Located at the southern end of Puget Sound, what is the capitol of Washington?", answer: "Olympia"),
        Card(question: "Which city serves as the capital of Texas?", answer: "Austin"),
        Card(question: "What is the capital of New York?", answer: "Albany"),
        Card(question: "Which city is the capital of Florida?", answer: "Tallahassee"),
        Card(question: "What is the capital of Colorado?", answer: "Denver")
    ]
}


struct CardView: View {
    
    let card: Card
    
    @State private var isShowingQuestion: Bool = true
    
    @State private var offset: CGSize = .zero
    
    private let swipeThreshold: Double = 200
    
    var onSwipedLeft: (() -> Void)?
    var onSwipedRight: (() -> Void)?
    

    
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 25.0) //
                .fill(isShowingQuestion ? Color.blue.gradient : Color.indigo.gradient)
                .shadow(color: .black, radius: 6, x:-2,y:2)
            
            VStack {
                Text(isShowingQuestion ? "Question" : "Answer")
                    .bold()
                
                Rectangle()
                    .frame(height: 1)
                
                Text(isShowingQuestion ? card.question : card.answer)
 
            }
            .font(.title)
            .foregroundStyle(.white)
            .padding()
            
        }
        .frame(width: 300, height: 500)
        .onTapGesture {
            isShowingQuestion.toggle()
        }
        .opacity(3 - abs(offset.width) / swipeThreshold * 3)
        .rotationEffect(.degrees(offset.width / 20.0))
        .offset(CGSize(width: offset.width, height: 0))
        .gesture(DragGesture()
            .onChanged { gesture in
                let translation = gesture.translation
                 print(translation)
                offset = translation
            }.onEnded { gesture in  // <-- onEnded called when gesture ends

                if gesture.translation.width > swipeThreshold { // <-- Compare the gesture ended translation value to the swipeThreshold
                    print("👉 Swiped right")
                    onSwipedRight?()

                } else if gesture.translation.width < -swipeThreshold {
                    print("👈 Swiped left")
                    onSwipedLeft?()

                } else {
                    print("🚫 Swipe canceled")
                }
            }
        )
        
    }
    
}

#Preview {
    let q = "Located at the southern end of Puget Sound, what is the capitol of Washington?"
    let a = "Olympia"
    let c = Card(question: q, answer: a)
    CardView(card: c)
}
