//
//  GameCollectionView.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

class GameCollectionView: UICollectionView {
    // MARK: - Outlets
    private var type: GameColletionTypes?

    // MARK: - Init
    init(type: GameColletionTypes) {
        self.type = type
        let layout = UICollectionViewLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup CollectionView
    private func setupCollectionView() {
        switch type {
        case .keyboard:
            self.collectionViewLayout = self.createLayout()
            self.register(KeyboardCell.self, forCellWithReuseIdentifier: KeyboardCell.reuseIdentifier)
        case .gameField:
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 4
            self.collectionViewLayout = layout
            self.register(GameBoardCell.self, forCellWithReuseIdentifier: GameBoardCell.reuseIdentifier)
        default:
            break
        }
        self.showsVerticalScrollIndicator = false
        self.isScrollEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
}

   // MARK: - GameField Layout method's extension
extension GameCollectionView {
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

   // MARK: - Keyboard Field method's extension
extension GameCollectionView {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / 12.0),
                                                                                     heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 1.0, leading: 1.0, bottom: 1.0, trailing: 1.0)

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                  heightDimension: .fractionalHeight(0.30)),
                                                                                                  subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 16)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 1.0, leading: 0.0, bottom: 1.0, trailing: 0.0)
                section.orthogonalScrollingBehavior = .continuous
                return section
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / 13.0),
                                                                                     heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 1.0, leading: 1.0, bottom: 1.0, trailing: 1.0)

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                  heightDimension: .fractionalHeight(0.30)),
                                                                                                  subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 0)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 1.0, leading: 30.0, bottom: 1.0, trailing: 30.0)
                section.orthogonalScrollingBehavior = .continuous
                return section
            case 2:
                let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.14),
                                                                                            heightDimension: .fractionalHeight(1.0)))
                leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 1.0, bottom: 0, trailing: 1.0)
                let centerItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / 9),
                                                                                           heightDimension: .fractionalHeight(1.0)))
                centerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 1.0, bottom: 0, trailing: 1.0)
                let centerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                                                                        heightDimension: .fractionalHeight(1.0)),
                                                                                                        subitems: [centerItem])
                let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.13),
                                                                                             heightDimension: .fractionalHeight(1.0)))
                trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 1.0, bottom: 0, trailing: 1.0)
                let parrentGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                         heightDimension: .fractionalHeight(0.30)),
                                                                      subitems: [leadingItem, centerGroup, trailingItem])
                parrentGroup.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 22.0, bottom: 0, trailing: 5.0)
                let section = NSCollectionLayoutSection(group: parrentGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 1.0, leading: 0.0, bottom: 1.0, trailing: 0.0)
                section.orthogonalScrollingBehavior = .continuous
                return section
            default:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                                                                     heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                                                                heightDimension: .fractionalHeight(0.9)),
                                                             subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
        return layout
    }
}

enum GameColletionTypes {
    case gameField
    case keyboard
}

