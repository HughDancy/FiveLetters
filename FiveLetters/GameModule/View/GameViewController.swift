//
//  GameViewController.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

class GameViewController: UIViewController {
    // MARK: - Properties
    var presenter: GamePresenterProtocol?
    private var guesses: [[Character?]] = Array(
        repeating: Array(repeating: nil, count: 5),
        count: 6
    )
    private var answer = ""

    // MARK: - Outlets
    let gamefieldController = GameboardController()
    let keyboardController = KeyboardController()

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchChars()
        self.answer = self.presenter?.getAnswer() ?? "дождь"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .label
        addChildren()
        let storage = StorageManager()
        storage.removeAllWords()
    }

    deinit {
        print("GameViewController is - ☠️")
    }

    // MARK: - Setup NavigationBar
    private func setupNavigationBar() {
        title = "5 букв"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }

    // MARK: - Add children
    private func addChildren() {
        addChild(keyboardController)
        keyboardController.delegate = self
        keyboardController.didMove(toParent: self)
        keyboardController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardController.view)

        addChild(gamefieldController)
        gamefieldController.gameBoardDelegate = self
        gamefieldController.didMove(toParent: self)
        gamefieldController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gamefieldController.view)
        setupLayout()
    }

    // MARK: - Setup Layout
    private func setupLayout() {
        NSLayoutConstraint.activate([
            gamefieldController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gamefieldController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gamefieldController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gamefieldController.view.bottomAnchor.constraint(equalTo: keyboardController.view.topAnchor),
            gamefieldController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

            keyboardController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    @objc func goBack() {
        self.presenter?.getBack()
    }
}

extension GameViewController: GameViewProtocol {
    func setKeyboardKeys(with keys: [Character : MatchType?]) {
        self.keyboardController.setupMatch(keys)
    }
    
    func getAnswer(_ answer: String) {
        self.answer = answer
    }
    
    func reloadKeyboard() {
        self.keyboardController.reloadData()
    }
    
    func reloadGameboard() {
        self.gamefieldController.reloadData()
    }
    
    func getChars(_ chars: [[Character?]]) {
        self.guesses = chars
    }
}

extension GameViewController: KeyboardDelegate {
    func keyboard(_ vc: UIViewController, didTapKey letter: Character) {
        self.presenter?.tapKeys(with: letter)
    }

    func didTapDoneKey()  {
        self.presenter?.tapDoneKey()
    }

        func didTapClearKey(_ vc: UIViewController) {
            self.presenter?.deleteChar()
        }
    }


extension GameViewController: GameBoardDelegate {
    var currentGuesses: [[Character?]] {
        return guesses
    }

    func setLetter(at indexPath: IndexPath) -> MatchType? {
        self.presenter?.setKeys(at: indexPath)
    }
}
