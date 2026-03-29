//
//  GameDictionary.swift
//  HackingWithSwift-Scamblet
//
//  Created by Michael Jones on 29/03/2026.
//

import Foundation

// handles loading all the possible words we have into a Set or fast searching.
// handles checking if a word is possible.

struct GameDictionary {
    // will internally track all the words that it's going to work with privately.
    private var words = Set<String>()
    
    // will try to open and read the dictionary.txt file.
    init() {
        
        // will try to locate the 'dictionary.txt' file.
        guard let url = Bundle.main.url(forResource: "dictionary", withExtension: "txt") else {
            fatalError("Unable to locate dictionary.txt file")
        }
        
        // will try to read the contents of the 'dictionary.txt' file.
        guard let string = try? String(contentsOf: url, encoding: .utf8) else {
            fatalError("Unable to read contents of dictionary.txt file")
        }
        
        // create an array of words from the contents of 'dictionary.txt'. Each element, is separated by a new line in the txt file.
        let allWords = string.components(separatedBy: "\n")
        
        // take the each word from 'allWords', inserts each one if the count of the word is less than or equal to 6.
        words = Set(allWords.filter{$0.count <= 6})
    }
    
    /// Tracks if we can conform a word from the target word.
    /// - Parameters:
    ///   - source: The word that we want to check against the target word.
    ///   - target: The target word that will be checked against the source.
    /// - Returns: Returns true if the source word contains letters that are within the target word.
    func canForm(_ source: String, from target: String) -> Bool {
        var target = target //variable copy of the target String.
        
        // loop over every letter in the source String.
        for letter in source {
            // tries to find the index position of the letter passed in.
            if let pos = target.firstIndex(of: letter) {
                // if available, remove the letter from the target String.
                target.remove(at: pos)
            } else {
                // if not available, we return false.
                return false
            }
        }
        // once we've gone through all the letters in the source String, we can return True.
        return true
    }
    
    // returns a [String] of words that can be spelled the target String.
    func spellableWords(from target: String) -> [String] {
        var result = [String]()
        
        for word in words {
            if canForm(word, from: target) {
                result.append(word)
            }
        }
        
        result.sort { first, second in
            if first.count == second.count {
                first < second
            } else {
                first.count < second.count
            }
        }
        
        return result
    }
    
}
