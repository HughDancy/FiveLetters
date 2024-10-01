//
//  MainProtocols.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }

}

protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    var router: MainRouterProtocol? { get set }
    func goToNewGame(from view: MainViewProtocol)
    func checkNewGame() -> Bool
}

protocol MainRouterProtocol: AnyObject {
    func goNewGame(from view: UIViewController)
}
