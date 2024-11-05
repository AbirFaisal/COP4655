//
//  ContentView.swift
//  TriviaGame
//
//  Created by Administrator on 11/3/24.
//

import SwiftUI

class ContentModel: ObservableObject {
    @Published var numberOfQuestions: Int = 1
    @Published var numberOfQuestionsString: String = "" {
        didSet {
            self.numberOfQuestions = Int(numberOfQuestionsString) ?? numberOfQuestions
            print(numberOfQuestions)
        }
    }

    @Published var category: Int = 0
    @Published var difficulty: Double = 0


    enum difficultyLevel: Double {
        case Easy = 1
        case Medium = 2
        case Hard = 3
    }

    @Published var selectedType = 0
    @Published var timerDuration = 10

}

//TODO ContentModelView

struct ContentView: View {

    @StateObject var model: ContentModel = .init()

    var body: some View {
        Text("Trivia Game")
            .font(.largeTitle)

        NavigationStack {

            Form {
//                TextField("Number of Questions", text: $model.numberOfQuestions2)
//                    .keyboardType(.numberPad)

                TextField("Number of Questions", text: $model.numberOfQuestionsString)
                    .keyboardType(.numberPad)


                Text("Select Category")

                //TODO change to picker
                Menu("Select Category", content: {
                    Text("General Knowledge").tag(1)
                    Text("Science & Nature").tag(2)
                    Text("History").tag(3)
                    Text("Geography").tag(4)
                    Text("Entertainment").tag(5)
                    Text("Sports").tag(6)
                    Text("Mythology").tag(7)
                })

                Text("Difficulty \(ContentModel.difficultyLevel(rawValue: model.difficulty) ?? .Easy)")
                Slider(value: $model.difficulty, in: 1...3, step: 1.0)


                Picker("Select Type", selection: $model.selectedType) {
                    Text("Multiple Choice").tag("multipleChoice").tag(0)
                    Text("True/False").tag("trueFalse").tag(1)
                }

                Picker("Timer Duration", selection: $model.timerDuration) {
                    Text("10 Seconds").tag(10)
                    Text("20 Seconds").tag(20)
                    Text("30 Seconds").tag(30)
                }


            }

            Spacer()


            //TODO change destination
            NavigationLink(destination: Text("TriviaView()")) {
                ZStack
                {
                    Rectangle()
                        .frame(width: 250, height: 50)
                        .cornerRadius(20)

                    Text("Start Game")
                        .foregroundColor(Color.white)
                }
            }

        }
        .padding()
        .onAppear() {

        }
    }
}

#Preview {
    ContentView()
}
