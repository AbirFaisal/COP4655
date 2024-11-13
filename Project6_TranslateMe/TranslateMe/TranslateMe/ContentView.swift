//
//  ContentView.swift
//  TranslateMe
//
//  Created by Administrator on 11/13/24.
//

import SwiftUI

struct ContentView: View {

    @State var text: String = ""
    @State var translation: String = "todo"
    @State var translationHistory: [String] = []

    @State var selectedLanguage: Int?

    func translate() {
        // TODO
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Enter Text", text: $text)

                Button("Translate Me") {
                    print("Hello, World!")
                }

                //TODO output area
                Text(translation)

                NavigationLink(destination: TranslationHistoryView()) {
                    Text("View Saved Translations")
                }

                Picker("Select Language", selection: $selectedLanguage) {
                    Text("TODO").id(0)
                }.pickerStyle(.navigationLink)


            }
            .navigationBarTitle("TranslateMe")
        }.padding()
    }
}

#Preview {
    ContentView()
}
