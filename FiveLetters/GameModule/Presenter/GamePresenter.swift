//
//  GamePresenter.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

final class GamePresenter: GamePresenterProtocol {
    // MARK: - Protocol properties
    weak var view: GameViewProtocol?
    var router: GameRouterProtocol?
    var model: GameModelProtocol?
    var isGameExist: Bool? {
        didSet {
            self.setupGame()
        }
    }

    // MARK: - Private properties
    private var guesses: [[Character?]] = Array(
        repeating: Array(repeating: nil, count: 5),
        count: 6
    )
    private var answer = "дождь"
    private var section = 0
    private var isWordComplete = [0 : false]
    private var lettersForKeyboard = [Character : MatchType?]()

    // MARK: - Setup Game
    func setupGame() {
        guard let bool = isGameExist else { return }
        if bool {
            self.answer = model?.getAnswer() ?? "дождь"
            let chars: [[Character?]] = Array(
                repeating: Array(repeating: nil, count: 5),
                count: 6
            )
            self.guesses = model?.getCharacters() ?? chars
            let sec = model?.getSection()
            self.section = sec ?? 0
            self.isWordComplete = model?.getWordsComplete() ?? [0 : false]
            print(sec)

        } else {
            self.answer = model?.getAnswer() ?? "Дождь"
        }
    }

    // MARK: - Protocol method's
    func fetchChars() {
        view?.getChars(self.guesses)
    }
    
    func getAnswer() -> String {
        self.answer = model?.getAnswer() ?? "дождь"
        return self.answer
    }
    
    func getBack() {
        guard let view = view  else { return }
        self.router?.dismiss(from: view)
    }
}

    // MARK: - Protocol methods for Keyboard
extension GamePresenter {
     func tapKeys(with char: Character) {
        var stop = false

        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = char
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
        model?.saveWord(guesses[section], index: section)
        model?.saveAnswer(self.answer)
//        let string = wordManager.convertToWord(guesses[section])
//        storageManager.saveWord(key: keys[section], word: string)
        self.view?.reloadGameboard()
        self.section += 1
        isWordComplete[section] = false
        if isWordComplete.count == 7 {
            guard let view = view else { return }
            self.router?.showGameOverAlert(from: view, answer: self.answer)
        }
    }

    private func reloadPropsForNewGame() {
//        self.answer = wordsStorage.collection?.words.randomElement() ?? "дождь"
        self.model?.removeWords()
        self.answer = model?.getAnswer() ?? "дождь"
        self.clearGuesses()
        self.section = 0
        self.isWordComplete = [0 : false]
        self.lettersForKeyboard = [Character : MatchType?]()
        self.view?.setKeyboardKeys(with: self.lettersForKeyboard)
        self.view?.reloadKeyboard()
        self.view?.reloadGameboard()
        self.view?.getChars(self.guesses)
        self.view?.getAnswer(self.answer)
    }

    private func clearGuesses() {
        self.guesses = Array(
            repeating: Array(repeating: nil, count: 5),
            count: 6
        )
    }
}

   // MARK: - Protocol Method's for Gameboard
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

 // MARK: - Extenstion for Router
extension GamePresenter: GamePresenterForRouterProtocol {
    func restart() {
        self.reloadPropsForNewGame()
    }
    
    func goBack() {
        guard let view = view else { return }
        self.router?.dismiss(from: view)
    }
}

