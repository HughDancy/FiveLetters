//
//  KeysType.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import Foundation

enum KeysType: Equatable {
    case gameField(MatchType)
    case keyboardType(KeyboardKeyType)
}

enum KeyboardKeyType {
    case standart
    case clear
    case done
}

enum MatchType {
    case fullMatch
    case wrongPlace
    case wrongLetter
    case standart
}

enum ActiveType {
    case active
    case unactive
}
