//
//  GamePresenter.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

final class GamePresenter: GamePresenterProtocol {
    weak var view: GameViewProtocol?
    var router: GameRouterProtocol?

    private var guesses: [[Character?]] = Array(
        repeating: Array(repeating: nil, count: 5),
        count: 6
    )
    private var answer = "дождь"
    private var section = 0
    private var isWordComplete = [0 : false]
    private var lettersForKeyboard = [Character : MatchType?]()

    func fetchChars() {
        
    }
    
    func getAnswer() -> String {
        return self.answer
    }
    
    func getBack() {
        guard let view = view  else { return }
        self.router?.dismiss(from: view)
    }
 
}

extension GamePresenter {
    func tapKeys(with char: Character) {
        var stop = false

        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = char
                    lettersForKeyboard[char] = .standart
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
        self.view?.getChars(self.guesses)
        self.view?.reloadGameboard()
    }

    func deleteChar() {
        var stop = false
        for (section, arr) in guesses.enumerated().reversed() {
            for (index, item) in arr.enumerated().reversed() {
                if item != nil {
                    guesses[section][index] = nil
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
        self.view?.getChars(self.guesses)
        self.view?.reloadGameboard()
    }

    func tapDoneKey() {
        isWordComplete.updateValue(true, forKey: section)
        self.view?.reloadGameboard()
        self.section += 1
        isWordComplete[section] = false
    }
}

extension GamePresenter {
    func setKeys(at indexPath: IndexPath) -> MatchType? {
        let rowIndex = indexPath.section
        if self.section == rowIndex {
        }

        let count = guesses[rowIndex].compactMap({ $0 }).count
        if count < 5 {
            return .standart
        } else if isWordComplete[rowIndex] == true {
            let indexedAnswer = Array(answer)

            guard let letter = guesses[indexPath.section][indexPath.row],
                  indexedAnswer.contains(letter) else {
                let character = guesses[indexPath.section][indexPath.row]
                self.lettersForKeyboard[character ?? "f"] = .wrongLetter
                self.view?.setKeyboardKeys(with: self.lettersForKeyboard)
                return .wrongLetter
            }

            if indexedAnswer[indexPath.row] == letter {
                self.lettersForKeyboard[letter] = .fullMatch
                self.view?.setKeyboardKeys(with: self.lettersForKeyboard)
                return .fullMatch
            }
            self.lettersForKeyboard[letter] = .wrongPlace
            self.view?.setKeyboardKeys(with: self.lettersForKeyboard)
            return .wrongPlace
        }
        return .standart
    }
}

