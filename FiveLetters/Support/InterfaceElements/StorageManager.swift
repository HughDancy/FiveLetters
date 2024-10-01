//
//  StorageManager.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import Foundation

final class StorageManager {
    let storage = UserDefaults.standard
    
    func saveWord(key: StorageKeys, word: String) {
        storage.setValue(word, forKey: key.rawValue)
    }
    
    func getWord(key: StorageKeys) -> String {
        return storage.string(forKey: key.rawValue) ?? "дождь"
    }
    
    func removeAllWords() {
        let allKeys = StorageKeys.allCases
        for key in allKeys {
            storage.removeObject(forKey: key.rawValue)
        }
    }
}

enum StorageKeys: String, CaseIterable {
    case firstWord
    case secondWord
    case thirdWord
    case fourWord
    case fiveWord
}
