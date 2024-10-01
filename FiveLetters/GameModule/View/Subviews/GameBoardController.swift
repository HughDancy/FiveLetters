//
//  GameBoardController.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

final class GameboardController: UIViewController{
    weak var gameBoardDelegate: GameBoardDelegate?

    private lazy var collectionView: GameCollectionView = {
        let collectionView = GameCollectionView(type: .gameField)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .clear
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GameBoardSizes.leading.value),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: GameBoardSizes.trailing.value),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: GameBoardSizes.top.value),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    public func reloadData() {
        collectionView.reloadData()
    }
}

extension GameboardController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gameBoardDelegate?.currentGuesses.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let guesses = gameBoardDelegate?.currentGuesses ?? []
        return guesses[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameBoardCell.reuseIdentifier, for: indexPath) as? GameBoardCell else {
            return UICollectionViewCell()
        }
        let guesess = gameBoardDelegate?.currentGuesses ?? []
        cell.type = .gameField(gameBoardDelegate?.setLetter(at: indexPath) ?? .standart)
        if let letter = guesess[indexPath.section][indexPath.row] {
            cell.setupBoardCell(with: letter)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/5
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 2,
            left: 2,
            bottom: 2,
            right: 2
        )
    }
}

fileprivate enum GameBoardSizes: CGFloat {
    case leading = 35
    case trailing = -35
    case top = 30

    var value: CGFloat {
        switch self {
        case .leading:
            UIScreen.main.bounds.height > 800 ? 16 : rawValue
        case .trailing:
            UIScreen.main.bounds.height > 800 ? -16 : rawValue
        case .top:
            UIScreen.main.bounds.height > 800 ? 68  : rawValue
        }
    }
}

