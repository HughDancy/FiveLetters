//
//  GameProtocols.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

protocol GameModelProtocol: AnyObject {
    func getAnswer() -> String
    func getCharacters() -> [[Character?]]
    func getSection() -> Int
    func getWordsComplete() -> [Int : Bool]
    func saveWord(_ chars: [Character?], index: Int)
    func saveAnswer(_ word: String)
    func checkGuessWord(_ char: [Character?]) -> Bool
    func removeWords()
}

protocol GameViewProtocol: AnyObject {
    var presenter: GamePresenterProtocol? { get set }
    
    func getChars(_ chars: [[Character?]])
    func setKeyboardKeys(with keys: [Character : MatchType?])
    func reloadKeyboard()
    func reloadGameboard()
}

protocol GamePresenterProtocol: AnyObject {
    var view: GameViewProtocol? { get set }
    var model: GameModelProtocol? { get set }
    var router: GameRouterProtocol? { get set }
    var isGameExist: Bool? { get set }

    func setupGame()
    func fetchChars()
    func getBack()
    func setKeys(at indexPath: IndexPath) -> MatchType? 
    func tapKeys(with char: Character)
    func deleteChar()
    func tapDoneKey()
}

protocol GamePresenterForRouterProtocol: AnyObject {
    func restart()
    func goBack()
}

protocol GameRouterProtocol: AnyObject {
    var presenter: GamePresenterForRouterProtocol? { get set }

    func dismiss(from view: GameViewProtocol)
    func showGameOverAlert(from view: GameViewProtocol, answer: String)
    func showCongratsAlert(from view: GameViewProtocol)
}


protocol GameBoardDelegate: AnyObject {
    var currentGuesses: [[Character?]] { get }
    func setLetter(at indexPath: IndexPath) -> MatchType?
}

protocol KeyboardDelegate: AnyObject {
    func keyboard(_ vc: UIViewController, didTapKey letter: Character)
    func didTapDoneKey()
    func didTapClearKey(_ vc: UIViewController)
}

