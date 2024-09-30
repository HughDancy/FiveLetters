//
//  ViewController.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

class MainController: UIViewController {
    // MARK: - Properties
    private var isGameExisting = false

    // MARK: - Outlets
    private lazy var startGameButton = BaseButton(title: "Начать новую игру")
    private lazy var continueGameButton: BaseButton = {
        let button = BaseButton(title: "Продолжить игру")
        button.isHidden = isGameExisting
        button.addTarget(self, action: #selector(goToGame), for: .touchDown)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
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
        
    }

}

fileprivate enum MainScreenSizes: CGFloat {
    case leading = 40
    case trailing = -40
    case bottom = -10
    case height = 56
}

