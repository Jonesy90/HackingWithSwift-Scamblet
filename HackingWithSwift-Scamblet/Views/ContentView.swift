//
//  ContentView.swift
//  HackingWithSwift-Scamblet
//
//  Created by Michael Jones on 29/03/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var dictionary = GameDictionary()
    @State private var targetWord = ""
    @State private var spellableWords = [String]()
    @State private var foundWords = Set<String>() // a Set of all the found words.
    
    @State private var letters = [Letter]() // all the available letters that can be selected to spell the word.
    @State private var currentWord = [Letter]() // all the letters the user has used in the spelled word.
    
    // creates a column [GridItem] which contains 3 columns.
    let columns = Array(repeating: GridItem(.flexible(minimum: 100, maximum: 150), spacing: 0), count: 3)
    
    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(columns: columns) {
                ForEach(spellableWords, id: \.self) { word in
                    Text(
                        // Displays the word if it's already found.
                        foundWords.contains(word) ? word.uppercased() : String(repeating: "*", count: word.count)
                    )
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            HStack {
                ForEach(currentWord) { letter in
                    Button {
                        remove(letter)
                    } label: {
                        Text(letter.text.uppercased())
                            .font(.largeTitle)
                            .frame(width: 44, height: 44)
                            .foregroundStyle(.white)
                            .background(.blue)
                    }
                }
                
                if currentWord.isEmpty {
                    Text("A")
                        .frame(width: 44, height: 44)
                        .hidden()
                }
            }
            .buttonStyle(.plain)
            
            HStack {
                ForEach(letters) { letter in
                    Button {
                        use(letter)
                    } label: {
                        Text(letter.text.uppercased())
                            .font(.largeTitle)
                            .frame(width: 44, height: 44)
                    }
                    .disabled(currentWord.contains(letter))
                }
            }
            
            Button("Submit", action: submit)
                .disabled(currentWord.count < 3)
        }
        .padding()
        .onAppear(perform: load)
    }
    
    func load() {
        targetWord = [
            "advert",
            "bestow",
            "brains",
            "carbon",
            "finale",
            "island",
            "nudges",
            "palete",
            "ransom",
            "sedate",
            "signed",
            "tailor",
            "tingle",
            "usable"
        ].randomElement()!
        
        spellableWords = dictionary.spellableWords(from: targetWord)
        spellableWords = rotate(items: spellableWords, columns: 3)
        
        letters = targetWord.shuffled().map {
            Letter(text: String($0))
        }
    }
    
    // adds letters from the currentWord.
    func use(_ letter: Letter) {
        withAnimation {
            currentWord.append(letter)
        }
    }
    
    // removes letters from the currentWord.
    func remove(_ letter: Letter) {
        withAnimation {
            if let index = currentWord.firstIndex(of: letter) {
                currentWord.remove(at: index)
            }
        }
    }
    
    func submit() {
        let spelled = currentWord.map(\.text).joined()
        
        guard foundWords.contains(spelled) == false else { return }
        
        if spellableWords.contains(spelled) {
            foundWords.insert(spelled)
        }
        
        currentWord.removeAll()
    }
    
//     reorganises the order of the array so it flows through the grid in columns instead of rows.
    func rotate(items: [String], columns: Int) -> [String] {
        let rows = (items.count + columns - 1) / columns
        var result = [String]()
        
        for row in 0..<rows {
            for col in 0..<columns {
                let index = col * rows + row
                if index < items.count {
                    result.append(items[index])
                }
            }
        }
        
        return result
    }
}

#Preview {
    ContentView()
}
