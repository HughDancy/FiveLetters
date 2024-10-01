//
//  StorageManager.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    let storage = UserDefaults.standard

    func saveAnswer(_ string: String) {
        storage.setValue(string, forKey: "answer")
    }

    func getAnswer() -> String? {
        storage.string(forKey: "answer")
    }

    func saveWord(key: WordsKeys, word: String) {
        storage.setValue(word, forKey: key.rawValue)
    }
    
    func getWord(key: WordsKeys) -> String? {
        return storage.string(forKey: key.rawValue)
    }
    
    func removeAllWords() {
        let allKeys = WordsKeys.allCases
        for key in allKeys {
            storage.removeObject(forKey: key.rawValue)
        }
        storage.removeObject(forKey: "answer")
    }
}

enum WordsKeys: String, CaseIterable {
    case firstWord
    case secondWord
    case thirdWord
    case fourWord
    case fiveWord
    case sixWord
}

