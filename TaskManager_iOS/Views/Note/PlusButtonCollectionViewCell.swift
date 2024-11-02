//
//  PlusButtonCollectionViewCell.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 02.11.2024.
//

import UIKit

class PlusButtonCollectionViewCell: UICollectionViewCell {
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            plusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            plusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
