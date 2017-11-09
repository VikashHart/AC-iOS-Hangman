//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var hangmanModel = twoPlayerHangmanModel()
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var guessInputField: UITextField!
    @IBOutlet weak var wordInputField: UITextField!
    @IBAction func newGameButton(_ sender: UIButton) {
        restartConditions()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guessInputField.delegate = self
        wordInputField.delegate = self
        restartConditions()
        
    }
    
    func restartConditions() {
        hangmanModel.startGame()
        guessInputField.isHidden = true
        guessInputField.isEnabled = false
        wordInputField.isHidden = false
        wordInputField.isEnabled = true
        placeholderLabel.text = ""
        statusLabel.text = "Hangman"
        wordInputField.text = ""
        guessInputField.text = ""
        hangmanImage.image = nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard string.isOnlyLetters() else { return false }

        guard let enteredLetter = textField.text else {
            return false
        }
        
        switch textField {
        case guessInputField:
            if guessInputField.text!.count > 0 { return false }
        case wordInputField:
            break
        default:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        
        switch textField {
        case wordInputField:
            hangmanModel.inputWord = text.lowercased()
            hangmanModel.createPlaceholders(word: text)
            placeholderLabel.text = hangmanModel.placeholder.joined(separator: "")
            
            guessInputField.isHidden = false
            guessInputField.isEnabled = true
            wordInputField.isHidden = true
            wordInputField.isEnabled = false
            
            return true
            
        case guessInputField:

            hangmanModel.letterChecker(inString: text.lowercased())
            
            switch hangmanModel.wrongAnswerCount {
            case 1:
                hangmanImage.image = #imageLiteral(resourceName: "man1")
            case 2:
                hangmanImage.image = #imageLiteral(resourceName: "man2")
            case 3:
                hangmanImage.image = #imageLiteral(resourceName: "man3")
            case 4:
                hangmanImage.image = #imageLiteral(resourceName: "man4")
            case 5:
                hangmanImage.image = #imageLiteral(resourceName: "man5")
            case 6:
                hangmanImage.image = #imageLiteral(resourceName: "man6")
            case 7:
                hangmanImage.image = #imageLiteral(resourceName: "man7")
            default:
                hangmanImage.image = nil
            }
            
            statusLabel.text = hangmanModel.statusMessage
            placeholderLabel.text = hangmanModel.placeholder.joined(separator: " ")
            guessInputField.text = ""
            hangmanModel.gameStatus()

            switch hangmanModel.winStatus{
            case .win:
                statusLabel.text = hangmanModel.statusMessage
                guessInputField.isEnabled = false
            case .lose:
                statusLabel.text = hangmanModel.statusMessage
                guessInputField.isEnabled = false
            default:
                break
            }
        default:
            break
        }
        
        return true
    }
}

//incrementor is wrong
//wordField takes any value
//
