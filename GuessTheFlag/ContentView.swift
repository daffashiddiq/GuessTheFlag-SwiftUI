//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daffashiddiq on 03/06/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var yourWrong = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var tappedCountry = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .alert(isPresented: $showingScore) {
                    Alert(title: Text(scoreTitle), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("Continue")) {
                        self.askQuestion()
                    })
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        tappedCountry = number
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                    .alert(isPresented: $yourWrong) {
                        Alert(title: Text(scoreTitle), message: Text("Wrong! That’s the flag of \(countries[tappedCountry])"), dismissButton: .default(Text("Continue")) {
                            self.askQuestion()
                        })
                    }
                }
                Text("\(userScore)")
                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
            }
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 100
            showingScore = true
        } else {
            scoreTitle = "Wrong"
            userScore -= 50
            yourWrong = true
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
