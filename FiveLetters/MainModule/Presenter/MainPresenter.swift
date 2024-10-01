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

    func goToGame(isGameExisting: Bool) {
        guard let view = view as? UIViewController else { return }
        router?.goToGame(from: view, isGameExisting: isGameExisting)
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
