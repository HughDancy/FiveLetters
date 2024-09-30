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

}


protocol GamePresenterProtocol: AnyObject {
    var view: GameViewProtocol? { get set }
    var router: GameRouterProtocol? { get set }

    func fetchChars()
    func getAnswer() -> String
    func getBack(view: GameViewProtocol)
    func setLetter(at indexPath: IndexPath) -> MatchType?
}

protocol GameRouterProtocol: AnyObject {
    func dismiss(from view: UIViewController)

}
