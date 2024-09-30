//
//  BaseCell.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//
import UIKit

class BaseCell: UICollectionViewCell {
    // MARK: - Outlet's
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        return view
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Prepare for reuse
    override func prepareForReuse() {
        self.label.text = nil
        self.container.backgroundColor = .label
        self.container.layer.borderColor = UIColor.white.cgColor
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup Hierarchy and Layout
    private func setupHierarchy() {
        self.container.addSubview(label)
        self.container.addSubview(image)
        self.contentView.addSubview(container)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: GameCellSizes.containerTopLeading.rawValue),
            container.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: GameCellSizes.containerTopLeading.rawValue),
            container.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: GameCellSizes.containerTrailingBottom.rawValue),
            container.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: GameCellSizes.containerTrailingBottom.rawValue),

            label.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),

            image.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

fileprivate enum GameCellSizes: CGFloat {
    case containerTopLeading = 0.5
    case containerTrailingBottom = -0.5
}

