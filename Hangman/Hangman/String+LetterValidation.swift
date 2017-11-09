import Foundation

extension String {
    private static let lowercasedEnglishLettersSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz")
    
    /*
     If any of the characters in the string are in the inverted set (ie the set of characters that are NOT lowercased LETTERS) then a range for such a character exists and that character is NOT a LETTER.
     If no range exists, then it is equivalent to saying that none of the letters are in the inverted set and therefore MUST all be lowercased LETTERS.
     */
    func isOnlyLetters() -> Bool {
        if self.lowercased()
            .rangeOfCharacter(from: String.lowercasedEnglishLettersSet.inverted) == nil {
            return true
        } else {
            return false
        }
    }
}
