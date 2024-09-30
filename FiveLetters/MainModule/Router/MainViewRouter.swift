//
//  MainViewRouter.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

final  class MainViewRouter: MainRouterProtocol {
    func goNewGame(from view: UIViewController) {
        let newViewController = GameViewController()
        view.navigationController?.pushViewController(newViewController, animated: true)
    }


}
