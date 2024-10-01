//
//  GameRouter.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

final class GameRouter: GameRouterProtocol {
    weak var presenter:  GamePresenterForRouterProtocol?
    func dismiss(from view: GameViewProtocol) {
        guard let currentView = view as? UIViewController else { return }
        currentView.navigationController?.popViewController(animated: true)
    }

    func showGameOverAlert(from view: any GameViewProtocol, answer: String) {
        guard let currentView = view as? UIViewController else { return }
        let alertController = UIAlertController(title: "Game Over",
                                                message: """
                                                К сожалению, попытки закончились 🙁
                                                Загаданное слово было - \(answer.uppercased()), но вы можете сыграть еще раз!
                                                """,
                                                preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Играть еще раз",
                                         style: .default) { _ in
            DispatchQueue.main.async {
                self.presenter?.restart()
            }
        }
        let cancelAction = UIAlertAction(title: "Выйти из игры",
                                         style: .cancel) { _ in
            self.presenter?.goBack()
        }
        alertController.addAction(restartAction)
        alertController.addAction(cancelAction)
        currentView.present(alertController, animated: true)
    }
}
