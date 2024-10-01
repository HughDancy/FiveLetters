//
//  GameProtocols.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

protocol GameViewProtocol: AnyObject {
    var presenter: GamePresenterProtocol? { get set }
    func getChars(_ chars: [[Character?]])
    func getAnswer(_ answer: String)
    func setKeyboardKeys(with keys: [Character : MatchType?])
    func reloadKeyboard()
    func reloadGameboard()

}


protocol GamePresenterProtocol: AnyObject {
    var view: GameViewProtocol? { get set }
    var router: GameRouterProtocol? { get set }

    func fetchChars()
    func getAnswer() -> String
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

}
