//
//  TriviaView.swift
//  TriviaGame
//
//  Created by Administrator on 11/3/24.
//

import SwiftUI

class QuestionModel: ObservableObject {
    @Published var question: String
    @Published var answers: [String]
    @Published var correctAnswer: String

    init(question: String, answers: [String], correctAnswer: String) {
        self.question = question
        self.answers = answers
        self.correctAnswer = correctAnswer
    }

}

class TriviaModel: ObservableObject {
    @Published var score: Int = 0
    @Published var questions: [QuestionModel]
    @Published var currentQuestion: QuestionModel?
    @Published var isGameOver: Bool = false

    init(questions: [QuestionModel]) {
        self.questions = questions
    }
}

struct TriviaView: View {

    @State var model: TriviaModel
    
    var body: some View {
        Text("Time Remaining:")

        Text("Score: \(model.score)")

        Text("Question: \(model.currentQuestion?.question ?? "")")

        Text("Answers: \(model.currentQuestion?.answers ?? [])")

        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(model.currentQuestion?.answers ?? [], id: \.self) { answer in
                    Button(action: {
                        if answer == model.currentQuestion?.correctAnswer {
                            model.score += 1
                        }
                    }) {
                        Text(answer)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.leading)
        }



    }
}

#Preview {
    var mockedQuesiton = QuestionModel(
        question: "What is the capital of France?",
        answers: ["Paris", "London", "Berlin", "Madrid"],
        correctAnswer: "Paris")

    var triviaModel = TriviaModel(questions: [mockedQuesiton])

    TriviaView(model: triviaModel)
}
