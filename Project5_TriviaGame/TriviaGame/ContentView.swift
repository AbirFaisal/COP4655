//
//  ContentView.swift
//  TriviaGame
//
//  Created by Administrator on 11/3/24.
//

import SwiftUI

class ContentModel: ObservableObject, Equatable {
    static func == (lhs: ContentModel, rhs: ContentModel) -> Bool {
        return false
    }

    @Published var numberOfQuestions: Int = 1
    @Published var numberOfQuestionsString: String = "5" {
        didSet {
            self.numberOfQuestions = Int(numberOfQuestionsString) ?? numberOfQuestions
            print(numberOfQuestions)
        }
    }

    @Published var categories: [Category] = []
    @Published var selectedCategory: Int = -1

    @Published var difficulty: Double = 0


    enum difficultyLevel: Double {
        case Easy = 1
        case Medium = 2
        case Hard = 3
    }

    @Published var selectedType = 0
    @Published var timerDuration = 10

}

struct Category: Codable, Identifiable {
    let id: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    var identifier: Int { id }
}

class ContentViewModel: ObservableObject {

    @Published var model: ContentModel = .init()
    @Published var trivia: TriviaModel

    init(model: ContentModel) {
        self.model = model

        let mockedQuesiton1 = QuestionModel(
            question: "Who was the only god from Greece who did not get a name change in Rome?",
            correctAnswer: "Apollo",
            incorrectAnswers: ["Demeter","Zeus","Athena"])

        let mockedQuesiton2 = QuestionModel(
            question: "What is the capital of Britan?",
            correctAnswer: "London",
            incorrectAnswers: ["Paris", "Berlin", "Madrid"])

        self.trivia = TriviaModel(questions: [mockedQuesiton1, mockedQuesiton2])

    }

    func fetchCategories() {
        print("fetchCategories()")

        let url = URL(string: "https://opentdb.com/api_category.php")!

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return }

            do {
                print("Fetched Categories")

                // Decode
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                let categoriesArr = jsonObject!["trivia_categories"] as? [[String: Any]]


                for obj in categoriesArr! {
                    let id = obj["id"] as! Int
                    let name = obj["name"] as! String

                    print(id, name)

                    self.model.categories.append(Category(id:id, name: name))
                }

//                print(self.model.categories)

                DispatchQueue.main.async {
                    print(self.model.categories)

                }
            } catch {
                print(error)
            }
        }.resume() //TODO find out what this does
    }

}

struct ContentView: View {

    @StateObject var viewModel: ContentViewModel
    @State private var categories: [Category] = []


    func fetchCategories() async {
        print("fetchCategories()")

        let url = URL(string: "https://opentdb.com/api_category.php")!


        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return }

            do {
                print("Fetched Categories")

                // Decode
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                let categoriesArr = jsonObject!["trivia_categories"] as? [[String: Any]]

//                var cats:[Category] = []

                for obj in categoriesArr! {
                    let id = obj["id"] as! Int
                    let name = obj["name"] as! String

                    print(id, name)

                    self.categories.append(Category(id:id, name: name))
                }

                DispatchQueue.main.async {
                    print(self.categories)

                }

            } catch {
                print(error)
            }
        }.resume() //TODO find out what this does
    }



    func fetchQuestions() -> TriviaModel? {
        print("fetchQuestions()")

        var questions: [QuestionModel] = []
        var tm: TriviaModel = TriviaModel(questions: questions)


        let amount = viewModel.model.numberOfQuestionsString
        let amountParam = "amount=\(amount)"

        let category = self.selectedCategory
        let  categoryParam = "category=\(category)"


        let difficutyLevels = ["easy", "medium", "hard"]
        let difficutyParam = "difficulty=\(difficutyLevels[Int(viewModel.model.difficulty)])"

        let questionType = ["multiple", "boolean"]
        let questionTypeParam = "type=\(questionType[viewModel.model.selectedType])"

        let url = URL(string: "https://opentdb.com/api.php?\(amountParam)&\(categoryParam)&\(difficutyParam)&\(questionTypeParam)")!

        print(url)

        Task {
            do {

                let (data, _) = try await URLSession.shared.data(from: url)

                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                let prettyPrintedData = try JSONSerialization.data(withJSONObject: jsonObject!, options: .prettyPrinted)
//                if let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8) {
//                    print(prettyPrintedString)
//                }

                let questionsArr = jsonObject!["results"] as? [[String: Any]]

                if questionsArr != nil
                {

                    var qArr: [QuestionModel] = []

                    for obj in questionsArr! {
                        let qText = obj["question"] as? String
                        let corAns = obj["correct_answer"] as? String
                        let incorAnsArr = obj["incorrect_answers"] as? [String]

                        let question = QuestionModel(question: qText!, correctAnswer: corAns!, incorrectAnswers: incorAnsArr!)

                        questions.append(question)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }

        print("Sucessfullay fetched questions")
        print(questions)

        return TriviaModel(questions: questions)
    }


    @State var selectedCategory: Int = -1

    var body: some View {

        Text("Trivia Game")
            .font(.largeTitle)

        NavigationStack {

            Form {
                TextField("Number of Questions", text: $viewModel.model.numberOfQuestionsString)
                    .keyboardType(.numberPad)

                Picker("Select Category", selection: $selectedCategory) {
                    Text("None").tag(-1)
                    ForEach(categories) { category in
                        Text("\(category.name)").tag(category.id)
                    }
                }


                Text("Difficulty \(ContentModel.difficultyLevel(rawValue: viewModel.model.difficulty) ?? .Easy)")
                Slider(value: $viewModel.model.difficulty, in: 1...3, step: 1.0)


                Picker("Select Type", selection: $viewModel.model.selectedType) {
                    Text("Multiple Choice").tag("multipleChoice").tag(0)
                    Text("True/False").tag("trueFalse").tag(1)
                }

                Picker("Timer Duration", selection: $viewModel.model.timerDuration) {
                    Text("10 Seconds").tag(10)
                    Text("20 Seconds").tag(20)
                    Text("30 Seconds").tag(30)
                }


            }

            Spacer()



            //TODO change destination
            NavigationLink(destination: TriviaView(model: viewModel.trivia)) {
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
        .onAppear(perform: {
            Task {
                await fetchCategories()
//                await viewModel.fetchCategories()
            }
        })
    }
}

#Preview {
    var model = ContentModel()

    ContentView(viewModel: ContentViewModel(model: model))
}
