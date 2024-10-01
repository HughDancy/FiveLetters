//
//  WordManager.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import Foundation

final class WordConverterManager {
    func convertToWord(_ chars: [Character?]) -> String {
        var string = ""
        for char in chars {
            guard let letter = char else { return "" }
               let str = String(letter)
               string += str
        }
        return string
    }

    func convertToChars(_ string: String) -> [Character] {
        var chars = [Character]()
        for char in string {
            chars.append(char)
        }
        return chars
    }
}
