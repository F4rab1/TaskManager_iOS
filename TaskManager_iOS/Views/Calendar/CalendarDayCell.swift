//
//  CalendarDayCell.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 26.07.2024.
//

import UIKit
import SnapKit

class CalendarDayCell: UICollectionViewCell {
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "Feb"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    let weekLabel: UILabel = {
        let label = UILabel()
        label.text = "Tue"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(red: 16, green: 94, blue: 245).cgColor
        layer.cornerRadius = 14
        clipsToBounds = true
        
        stackView.addArrangedSubview(monthLabel)
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(weekLabel)
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureForSelectedState() {
        backgroundColor = UIColor(red: 16, green: 94, blue: 245)
        monthLabel.textColor = .white
        dayLabel.textColor = .white
        weekLabel.textColor = .white
    }
    
    func configureForDeselectedState() {
        backgroundColor = .white
        monthLabel.textColor = .black
        dayLabel.textColor = .black
        weekLabel.textColor = .black
    }
    
}
