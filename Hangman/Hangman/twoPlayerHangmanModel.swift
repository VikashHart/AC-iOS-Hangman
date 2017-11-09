//
//  HangmanModel.swift
//  Hangman
//
//  Created by C4Q on 10/31/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation
enum winState{
    case win
    case lose
    case playing
}

class twoPlayerHangmanModel {
    
    var inputWord = ""
    var placeholder = [String]()
    var guessedLetters = [String]()
    var wrongAnswerCount: Int = 0
    var statusMessage = "Hangman"

    var winStatus: winState = .playing
    
    func startGame() {
        placeholder = []
        inputWord = String()
        guessedLetters = [String]()
        wrongAnswerCount = 0
        statusMessage = "Hangman"
        winStatus = .playing
        
    }
    
    func createPlaceholders(word: String) {
        placeholder = Array(repeating: "_ ", count: word.count)
    }
    
    
    func letterChecker(inString string: String) {
        let lowerCasedLetter = string.lowercased()
        
        guard string.isOnlyLetters()
            && !guessedLetters.contains(lowerCasedLetter)
            else { return }
        
        guard inputWord.contains(lowerCasedLetter) else {
            wrongAnswerCount += 1
            statusMessage = "Incorrect"
            return
        }
        
        statusMessage = "Correct"
        for (index, letter) in inputWord.lowercased().enumerated() {
            if lowerCasedLetter == "\(letter)" {
                placeholder[index] = String(letter)
                guessedLetters.append(String(letter))
            }
        }
    }
    
    
    func gameStatus() {
        if !placeholder.contains("_ ") {
            winStatus = .win
            statusMessage = "You Win"
        } else if wrongAnswerCount == 7 {
            statusMessage = "You Lose"
            winStatus = .lose
        } else {
            winStatus = .playing
        }
        
    }
    
}
