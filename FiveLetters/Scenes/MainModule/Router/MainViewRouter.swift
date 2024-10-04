//
//  MainViewRouter.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

final  class MainViewRouter: MainRouterProtocol {
    func goToGame(from view: UIViewController, isGameExisting: Bool) {
        if isGameExisting {
            let gameModule = AssemblyBuilder.createGameModule(isGameExist: true)
            view.navigationController?.pushViewController(gameModule, animated: true)
        } else {
            let gameModule = AssemblyBuilder.createGameModule(isGameExist: false)
            view.navigationController?.pushViewController(gameModule, animated: true)
        }
    }
}
