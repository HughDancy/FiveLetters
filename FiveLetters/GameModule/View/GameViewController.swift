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
    private var section = 0
    private var isWordComplete = [0 : false]
    private var lettersForKeyboard = [Character : MatchType?]()

    // MARK: - Outlets
    let gameVc = BoardViewController()
    let keyboardVc = KeyboardController()

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
    }

    // MARK: - Setup NavigationBar
    private func setupNavigationBar() {
        title = "5 букв"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }

    // MARK: - Setup View
    private func addChildren() {
        addChild(keyboardVc)
        keyboardVc.delegate = self
        keyboardVc.didMove(toParent: self)
        keyboardVc.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVc.view)

        addChild(gameVc)
        gameVc.gameBoardDelegate = self
        gameVc.didMove(toParent: self)
        gameVc.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameVc.view)
        setupLayout()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            gameVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameVc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameVc.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameVc.view.bottomAnchor.constraint(equalTo: keyboardVc.view.topAnchor),
            gameVc.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

            keyboardVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVc.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    @objc func goBack() {
        self.presenter?.getBack(view: self)
    }
}

extension GameViewController: GameViewProtocol {
    func getChars(_ chars: [[Character?]]) {
        self.guesses = chars
    }
}

extension GameViewController: KeyboardDelegate {
    func keyboard(_ vc: UIViewController, didTapKey letter: Character) {
        var stop = false

        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    lettersForKeyboard[letter] = .standart
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
        gameVc.reloadData()
    }

    func didTapDoneKey()  {
        isWordComplete.updateValue(true, forKey: section)
        self.gameVc.reloadData()
        self.section += 1
        isWordComplete[section] = false

    }

        func didTapClearKey(_ vc: UIViewController) {
            var stop = false
            for (section, arr) in guesses.enumerated().reversed() {
                for (index, item) in arr.enumerated().reversed() {
                    if item != nil {
                        guesses[section][index] = nil
                        stop = true
                        break
                    }
                }
                if stop {
                    break
                }
            }
            gameVc.reloadData()
        }
    }


extension GameViewController: GameBoardDelegate {
    var currentGuesses: [[Character?]] {
        return guesses
    }

    func setLetter(at indexPath: IndexPath) -> MatchType? {
        let rowIndex = indexPath.section
        if self.section == rowIndex {
        }

        let count = guesses[rowIndex].compactMap({ $0 }).count
        if count < 5 {
            return .standart
        } else if isWordComplete[rowIndex] == true {
            let indexedAnswer = Array(answer)

            guard let letter = guesses[indexPath.section][indexPath.row],
                  indexedAnswer.contains(letter) else {
                let character = guesses[indexPath.section][indexPath.row]
                self.lettersForKeyboard[character ?? "f"] = .wrongLetter
                keyboardVc.setupMatch(self.lettersForKeyboard)
                return .wrongLetter
            }

            if indexedAnswer[indexPath.row] == letter {
                self.lettersForKeyboard[letter] = .fullMatch
                keyboardVc.setupMatch(self.lettersForKeyboard)
                return .fullMatch
            }
            self.lettersForKeyboard[letter] = .wrongPlace
            keyboardVc.setupMatch(self.lettersForKeyboard)
            return .wrongPlace
        }
        return .standart
    }
}
