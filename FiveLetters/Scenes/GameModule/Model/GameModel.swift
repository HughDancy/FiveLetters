//
//  GameModel.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import Foundation

final class GameModel: GameModelProtocol {
    // MARK: - Properties
    private let wordsCollection = WordsCollection()
    private let wordConverterManager = WordConverterManager()
    private let storageManager = StorageManager.shared
    private let keys = WordsKeys.allCases

    // MARK: - Protocol Method's
    func getSavedAnswer() -> String {
        let safedAnser = storageManager.getAnswer()
        return safedAnser ?? "Дождь"
    }

    func getRandowAnswer() -> String {
        return wordsCollection.getRandomWord()
    }

    func getEmptyCharacters() -> [[Character?]] {
        return  Array(
            repeating: Array(repeating: nil, count: 5),
            count: 6)
    }

    func getSavedCharacters() -> [[Character?]] {
        var chars = [[Character?]]()
        let words = self.getAllWords()
        for (index, _) in words.enumerated() {
            var char: [Character?] = wordConverterManager.convertToChars(words[index] ?? "")
            if char.isEmpty {
                for _ in 0..<5 {
                    char.append(nil)
                }
            }
            chars.append(char)
        }
        return chars
    }

    func getSection() -> Int {
        var count = 0
        let words = self.getAllWords()
        for i in 0..<5 {
            if words[i]?.compactMap({$0}).count != nil {
                count += 1
            }
        }
        return count
    }

    func getIsWordComplete() -> [Int : Bool] {
        let words = self.getAllWords()
        var isWordComplete = [Int : Bool]()
        for i in 0..<5 {
            if words[i]?.compactMap({$0}).count != nil {
                isWordComplete[i] = true
            } else {
                isWordComplete[i] = false
            }
        }
        return isWordComplete
    }

    func saveWord(_ chars: [Character?], index: Int) {
        let string = wordConverterManager.convertToWord(chars)
        if index < 6 {
            self.storageManager.saveWord(key: keys[index], word: string)
        }
    }

    func saveAnswer(_ word: String) {
        storageManager.saveAnswer(word)
    }

    func removeWords() {
        self.storageManager.removeAllWords()
    }

    func checkGuessWord(_ char: [Character?]) -> Bool {
        let chars = char.compactMap { $0 }
        let str = wordConverterManager.convertToWord(chars)
        let answer = storageManager.getAnswer()
        return str == answer ? true : false
    }
}

extension GameModel {
    private func getAllWords() -> [String?] {
        var words = [String?]()
        for (index, _) in keys.enumerated() {
            let word = storageManager.getWord(key: keys[index])
            words.append(word)
        }
        return words
    }
}
