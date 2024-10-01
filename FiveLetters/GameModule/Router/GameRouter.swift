//
//  GameRouter.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

final class GameRouter: GameRouterProtocol {
    func dismiss(from view: GameViewProtocol) {
        guard let currentView = view as? UIViewController else { return }
        currentView.navigationController?.popViewController(animated: true)
    }
}
