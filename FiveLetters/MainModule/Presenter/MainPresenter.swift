//
//  MainPresenter.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?

    func goToNewGame(from view: any MainViewProtocol) {
        guard let view = view as? UIViewController else { return }
        router?.goNewGame(from: view)
    }

    func checkNewGame() -> Bool {
        let storageManager = StorageManager()
        let word: String? = storageManager.getWord(key: WordsKeys.firstWord)
        if word == nil {
            return false
        } else {
            return true
        }
    }
}
