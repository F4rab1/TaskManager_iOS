//
//  TaskTableViewCell.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 01.08.2024.
//

import UIKit
import SnapKit

class TaskTableViewCell: UITableViewCell {
    
    private let shadowContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.blue.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(red: 171, green: 206, blue: 245).cgColor
        view.layer.borderWidth = 0.7
        view.layer.masksToBounds = true
        return view
    }()
    
    let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 16, green: 94, blue: 245)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 16, green: 94, blue: 245)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Title"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Category"
        return label
    }()
    
    let stageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 16, green: 94, blue: 245)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "In Progress"
        return label
    }()
    
    let stageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark.circle")
        imageView.tintColor = .green
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        
        contentView.addSubview(shadowContainerView)
        shadowContainerView.addSubview(containerView)
        containerView.addSubview(leftView)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(stageLabel)
        containerView.addSubview(stageImageView)
    }
    
    func setupConstraints() {
        shadowContainerView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(8)
            make.leading.trailing.equalTo(contentView).inset(12)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(shadowContainerView)
        }
        
        leftView.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading)
            make.width.equalTo(3)
            make.height.equalTo(50)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(containerView).inset(15)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.leading.equalTo(containerView).inset(15)
        }
        
        stageLabel.snp.makeConstraints { make in
            make.bottom.leading.equalTo(containerView).inset(15)
        }
        
        stageImageView.snp.makeConstraints { make in
            make.leading.equalTo(stageLabel.snp.trailing).offset(10)
            make.bottom.equalTo(containerView).inset(15)
            make.width.height.equalTo(20)
        }
    }
}
