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
    
    // creates a column [GridItem] which contains 3 columns.
    let columns = Array(repeating: GridItem(.flexible(minimum: 100, maximum: 150), spacing: 0), count: 3)
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(spellableWords, id: \.self) { word in
                    Text(word.uppercased())
                        .font(.title3)
                }
            }
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
    }
}

#Preview {
    ContentView()
}
