//
//  KeyboardController.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

final class KeyboardController: UIViewController {
    weak var delegate: KeyboardDelegate?
    private let letters = ["йцукенгшщзхъ", "фывапролджэ","vячсмитьбю*"]
    private var keys = [[Character]]()
    private var guesesWord = [Character]()
    private var matchedKeys = [Character : MatchType?]()

    // MARK: - Outlets
    private lazy var keyboardCollection: GameCollectionView = {
        let collectionView = GameCollectionView(type: .keyboard)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupView()
    }

    // MARK: - Setup View methods
    private func setupView() {
        view.addSubview(keyboardCollection)
        setupLayout()
        setupLetters()
    }

    private func setupLetters() {
        for char in letters {
            let chars = Array(char)
            keys.append(chars)
        }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            keyboardCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            keyboardCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            keyboardCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            keyboardCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - Support method for update keyboard state
    func reloadData() {
        self.keyboardCollection.reloadData()
    }

    func setupMatch(_ mathced: [Character : MatchType?]) {
        self.matchedKeys = mathced
        self.keyboardCollection.reloadData()
    }
}

// MARK: - UICollection Data Source extension
extension KeyboardController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        keys.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        keys[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyboardCell.reuseIdentifier, for: indexPath) as? KeyboardCell else {
            return UICollectionViewCell()
        }
        let letter = keys[indexPath.section][indexPath.row]

        switch letter {
        case "v":
            cell.type = .keyboardType(.done)
            if guesesWord.count < 5 {
                cell.activeType = .unactive
            } else {
                cell.activeType = .active
            }
        case "*":
            cell.type = .keyboardType(.clear)
            if guesesWord.count > 0 {
                cell.activeType = .active
            } else if guesesWord.count == 0 {
                cell.activeType = .unactive
            }
        default:
            cell.type = .keyboardType(.standart)
        }

        cell.setupKeyboardCell(with: letter)

        let keys = matchedKeys.keys
        for key in keys {
            if key == letter {
                cell.setupMatchType(with: (matchedKeys[key] ?? .standart) ?? .standart)
            }
        }
        return cell
    }
}
    // MARK: - UICollectionView Delegate Extension
extension KeyboardController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let letter = keys[indexPath.section][indexPath.row]
        switch letter {
        case "v":
            if guesesWord.count == 5 {
                self.guesesWord.removeAll()
                self.keyboardCollection.reloadData()
                delegate?.didTapDoneKey()
            }
        case "*":
            if guesesWord.count > 0 {
                delegate?.didTapClearKey(self)
                guesesWord.removeLast()
                self.keyboardCollection.reloadData()
            }
        default:
            if guesesWord.count < 5 {
                delegate?.keyboard(self, didTapKey: letter)
                guesesWord.append(letter)
                self.keyboardCollection.reloadData()
            }
        }
    }
}

