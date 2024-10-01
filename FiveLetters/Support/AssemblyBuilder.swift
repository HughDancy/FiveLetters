//
//  AssemblyBuilder.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

final class AssemblyBuilder {

    static func createMainModule() -> UIViewController {
        let view = MainController()
        let presenter: MainPresenterProtocol = MainPresenter()
        let router: MainViewRouter = MainViewRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        let navViewController = UINavigationController(rootViewController: view)
        return navViewController
    }

    static func createGameModule(isGameExist: Bool) -> UIViewController {
        let view = GameViewController()
        let presenter: GamePresenterProtocol & GamePresenterForRouterProtocol = GamePresenter()
        let gameModel: GameModelProtocol = GameModel()
        let router: GameRouterProtocol = GameRouter()
        if isGameExist {
            presenter.isGameExist = true
        } else {
            presenter.isGameExist = false
        }
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.model = gameModel
        router.presenter = presenter
        return view
    }
}
