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

    init(question: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.question = question
//        self.answers = incorrectAnswers
        self.answers = incorrectAnswers + [correctAnswer]

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
        self.currentQuestion = questions.first
    }
}

class TriviaViewModel: ObservableObject {

}

struct TriviaView: View {

    @State var model: TriviaModel

    func nextQuestion() {
        model.currentQuestion = model.questions.randomElement()
    }

    var body: some View {


        VStack {
            Text("Time Remaining:")

            Text("Score: \($model.score.wrappedValue)")

            Spacer()

            Text("Question: \(model.currentQuestion?.question ?? "")")
                .font(.largeTitle)

            Spacer()

            VStack(alignment: .center, spacing: 10) {

                ForEach(model.currentQuestion?.answers ?? [], id: \.self) { answer in
                    Button(action: {
                        print("Answer pressed: \(answer) \(model.currentQuestion?.correctAnswer ?? "")")
                        if answer == model.currentQuestion?.correctAnswer {
                            $model.score.wrappedValue += 1
                            print("Correct Answer \(model.score)")
                            nextQuestion()
                        }
                        else {
                            print("Wrong Answer \(model.score)")
                            nextQuestion()
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


            Spacer()


        }


    }
}

#Preview {
    let mockedQuesiton1 = QuestionModel(
        question: "What is the capital of France?",
        correctAnswer: "Paris",
        incorrectAnswers: ["London", "Berlin", "Madrid"])

    let mockedQuesiton2 = QuestionModel(
        question: "What is the capital of Britan?",
        correctAnswer: "London",
        incorrectAnswers: ["Paris", "Berlin", "Madrid"])


    var triviaModel = TriviaModel(questions: [mockedQuesiton1, mockedQuesiton2])

    TriviaView(model: triviaModel)
}
