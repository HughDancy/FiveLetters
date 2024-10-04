//
//  BaseButton.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit

final class BaseButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        setTitleColor(.label, for: .normal)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16
    }
}
