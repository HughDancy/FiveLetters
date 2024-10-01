//
//  ViewController.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

class MainController: UIViewController, MainViewProtocol {
    // MARK: - Properties
    private var isGameExisting: Bool?
    var presenter: MainPresenterProtocol?

    // MARK: - Outlets
    private lazy var startGameButton: BaseButton = {
        let button = BaseButton(title: "Начать новую игру")
        button.addTarget(self, action: #selector(goToGame), for: .touchDown)
        return button
    }()

    private lazy var continueGameButton: BaseButton = {
        let button = BaseButton(title: "Продолжить игру")
        if let boolean = isGameExisting {
            button.isHidden = !boolean
            print(boolean)
        }
        button.addTarget(self, action: #selector(goToGame), for: .touchDown)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .label
        self.isGameExisting  = presenter?.checkNewGame()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup Hierarchy and Layout
    private func setupHierarchy() {
        view.addSubview(startGameButton)
        view.addSubview(continueGameButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            startGameButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            startGameButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: MainScreenSizes.leading.rawValue),
            startGameButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: MainScreenSizes.trailing.rawValue),
            startGameButton.heightAnchor.constraint(equalToConstant: MainScreenSizes.height.rawValue),

            continueGameButton.bottomAnchor.constraint(equalTo: startGameButton.topAnchor, constant: MainScreenSizes.bottom.rawValue),
            continueGameButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: MainScreenSizes.leading.rawValue),
            continueGameButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: MainScreenSizes.trailing.rawValue),
            continueGameButton.heightAnchor.constraint(equalToConstant: MainScreenSizes.height.rawValue),

        ])
    }

    @objc func goToGame() {
        self.presenter?.goToGame(isGameExisting: true)
    }

    @objc func continueGame() {
        self.presenter?.goToGame(isGameExisting: false)
    }

}

fileprivate enum MainScreenSizes: CGFloat {
    case leading = 40
    case trailing = -40
    case bottom = -10
    case height = 56
}

