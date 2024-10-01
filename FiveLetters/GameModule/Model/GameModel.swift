//
//  GameModel.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import Foundation

final class GameModel: GameModelProtocol {
    // MARK: - Properties
    private let wordsStorage = WordsCollection()
    private let wordManager = WordManager()
    private let storageManager = StorageManager()
    private let keys = WordsKeys.allCases

    // MARK: - Protocol Method's
    func getAnswer() -> String {
        return self.wordsStorage.getRandomWord()
    }
    
    func getCharacters() -> [[Character?]] {
        var chars = [[Character?]]()
        var words = [String?]()
        for (index, _) in keys.enumerated() {
            let word = storageManager.getWord(key: keys[index])
            words.append(word)
        }
        for (index, _) in words.enumerated() {
            var char: [Character?] = wordManager.convertToChars(words[index] ?? "")
            if char.isEmpty {
                for _ in 0..<5 {
                    char.append(nil)
                }
            }
            chars.append(char)
        }
        return chars
    }
    
    func saveWord(_ chars: [Character?], index: Int) {
        let string = wordManager.convertToWord(chars)
        if index > 6 {
            self.storageManager.saveWord(key: keys[index], word: string)
        }
    }

    func saveAnswer(_ word: String) {
        storageManager.saveAnswer(word)
    }

    func removeWords() {
        self.storageManager.removeAllWords()
    }
    
    
}
