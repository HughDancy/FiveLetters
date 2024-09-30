//
//  KeyboardCell.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

class KeyboardCell: BaseCell {
    static let reuseIdentifier = "KeyboardCell"
    var type: KeysType? = .keyboardType(.standart)
    var activeType: ActiveType? = .unactive
    var matchType: MatchType? = .standart

    func setupKeyboardCell(with string: Character) {
        switch self.type {
        case .keyboardType(.standart):
            self.label.text = String(string)
            label.font = UIFont.systemFont(ofSize: 26, weight: .medium)
            self.container.backgroundColor = .label
        case .keyboardType(.clear):
            self.addImageToKey(type: .clear, active: self.activeType ?? .unactive)
        case .keyboardType(.done):
            self.addImageToKey(type: .done, active: self.activeType ?? .unactive)
        default:
            self.label.text = String(string)
            label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
            self.container.backgroundColor = .systemGray
        }
    }

    func setupMatchType(with match: MatchType) {
        switch match {
        case .fullMatch:
            self.container.backgroundColor = .systemGreen
            self.label.textColor = .label
        case .wrongPlace:
            self.container.backgroundColor = .white
            self.label.textColor = . label
        case .wrongLetter:
            self.container.backgroundColor = .systemGray
            self.label.textColor = .white
        case .standart:
            self.container.backgroundColor = .label
        }
    }

    private func addImageToKey(type: SupportKeys, active: ActiveType) {
        self.label.text = nil
        self.image.isHidden = false
        self.container.layer.borderColor = UIColor.clear.cgColor
        switch type {
        case .done:
            self.image.image = UIImage(systemName: "checkmark")
        case .clear:
            self.image.image = UIImage(systemName: "delete.backward")
        }

        switch self.activeType {
        case .active:
            self.container.backgroundColor = .white
            self.image.tintColor = .label
            self.isUserInteractionEnabled = true
        case .unactive:
            self.container.backgroundColor = .gray
            self.image.tintColor = .white
            self.isUserInteractionEnabled = false
        default:
            break
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
        self.type = nil
        self.activeType = nil
        self.matchType = nil
        self.label.textColor = .white
        self.isUserInteractionEnabled = true
    }
}

fileprivate enum SupportKeys {
    case done
    case clear
}
