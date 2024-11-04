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
}

struct ContentView: View {

    @StateObject var model: ContentModel = .init()

    var body: some View {

        VStack {
            Text("Trivia Game")

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

                HStack
                {
                    Text("Select Type")

                    Menu("Select Type", content: {
                        Text("Multiple Choice")
                        Text("True/False")
                    })
                }

                Text("Timer Duration")

                //TODO change to picker
                Menu("Select Timer Duration", content: {
                    Text("10 Seconds").tag(10)
                    Text("20 Seconds").tag(20)
                    Text("30 Seconds").tag(30)
                })

            }

            Spacer()


            NavigationLink(destination: Text("Destination")) {
                Text("Navigation Link")
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
