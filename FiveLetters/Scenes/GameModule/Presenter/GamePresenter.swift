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
    var isGameExist: Bool?

    // MARK: - Private properties
    private var guesses = [[Character?]]()
    private var answer = "дождь"
    private var section = 0
    private var isWordComplete = [0 : false]
    private var lettersForKeyboard = [Character : MatchType?]()

    // MARK: - Setup Game
    func setupGame() {
        guard let bool = isGameExist else { return }

        if bool {
            self.answer = model?.getSavedAnswer() ?? "дождь"
            guard let chars = model?.getSavedCharacters() else { return }
            self.guesses = chars
            let sec = model?.getSection()
            self.section = sec ?? 0
            self.isWordComplete = model?.getIsWordComplete() ?? [0 : false]
        } else {
            guard let emptyChars = self.model?.getEmptyCharacters() else { return }
            self.guesses = emptyChars
            self.answer = model?.getRandowAnswer() ?? "дождь"
        }
    }

    // MARK: - Protocol method's
    func fetchChars() {
        view?.getChars(self.guesses)
    }
    
    func getBack() {
        guard let view = view  else { return }
        if section > 0 {
            self.sendNotification(with: true)
        } else {
            self.sendNotification(with: false)
        }
        self.router?.dismiss(from: view)
    }
}

    // MARK: - Protocol methods for Keyboard
   /// Tap on letter, tap on done and cleap button
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
        if section == 0 {
            model?.saveAnswer(self.answer)
        }
        self.view?.reloadGameboard()
        self.checkWord()
        self.section += 1
        isWordComplete[section] = false
        self.checkGameOver()
    }
}

   // MARK: - Protocol Method's for Gameboard
  /// Set gameboard and keyboard state -- wrong letter, wrong place and full match
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

   // MARK: - Support methods
  /// Reload properites for new game, clean guess word and check answer
extension GamePresenter {
    private func reloadPropsForNewGame() {
        self.sendNotification(with: false)
        self.model?.removeWords()
        self.answer = model?.getRandowAnswer() ?? "дождь"
        self.clearGuesses()
        self.view?.getChars(self.guesses)
        self.section = 0
        self.isWordComplete = [0 : false]
        self.lettersForKeyboard = [Character : MatchType?]()
        self.view?.setKeyboardKeys(with: self.lettersForKeyboard)
        self.view?.reloadKeyboard()
        self.view?.reloadGameboard()
    }

    private func clearGuesses() {
        guard let emptyChars = self.model?.getEmptyCharacters() else {  return }
        self.guesses = emptyChars
    }

    private func checkWord() {
        if model?.checkGuessWord(guesses[section]) ?? false {
            guard let view = view else { return }
            router?.showCongratsAlert(from: view)
        }
    }

    private func checkGameOver() {
        if isWordComplete.count == 7 {
            guard let view = view else { return }
            self.router?.showGameOverAlert(from: view, answer: self.answer)
        }
    }

    private func sendNotification(with bool: Bool) {
        let value = ["gameExist" : bool]
        NotificationCenter.default.post(name: NSNotification.Name("isGameExist"), object: nil, userInfo: value)
    }
}

