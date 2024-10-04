//
//  GameBoardCell.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

class GameBoardCell: BaseCell {
    static let reuseIdentifier = "GameBoardCell"
    var type: KeysType? = .gameField(.standart)

    func setupBoardCell(with string: Character) {
        switch self.type {
        case .gameField(.wrongLetter):
            self.label.text = String(string).uppercased()
            label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
            self.container.backgroundColor = .systemGray
            self.label.textColor = .white
        case .gameField(.wrongPlace):
            self.label.text = String(string).uppercased()
            label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
            self.container.backgroundColor = .white
            self.label.textColor = . label
        case .gameField(.fullMatch):
            self.label.text = String(string).uppercased()
            label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
            self.container.backgroundColor = .systemGreen
            self.label.textColor = .label
        case .gameField(.standart):
            self.label.text = String(string).uppercased()
            self.container.backgroundColor = .label
            self.label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
            self.label.textColor = .white
        default:
            self.label.text = String(string).uppercased()
            label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
            self.container.backgroundColor = .systemGray
        }
    }
}
