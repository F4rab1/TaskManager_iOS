//
//  TaskTableViewCell.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 01.08.2024.
//

import UIKit
import SnapKit

class TaskTableViewCell: UITableViewCell {
    
    var isCompleted: Bool = false {
        didSet {
            configureStage()
        }
    }
    
    private let shadowContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        view.layer.borderWidth = 0.7
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 23, green: 162, blue: 184)
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Title"
        
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Category"
        
        return label
    }()
    
    let stageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .green
        
        return imageView
    }()
    
    let stageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    let priorityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(red: 23, green: 162, blue: 184)
        imageView.image = UIImage(systemName: "flag.square.fill")
        
        return imageView
    }()
    
    let priorityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "HIGH"
        
        return label
    }()
    
    func configureStage() {
        stageLabel.text = isCompleted ? "COMPLETED" : "IN PROGRESS"
        stageLabel.textColor = isCompleted ? UIColor(red: 23, green: 162, blue: 184) : UIColor.gray
        stageImageView.image = UIImage(named: isCompleted ? "completed" : "in_progress")
    }
    
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
        configureStage()
        
        contentView.addSubview(shadowContainerView)
        shadowContainerView.addSubview(containerView)
        containerView.addSubview(leftView)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(stageLabel)
        containerView.addSubview(stageImageView)
        containerView.addSubview(priorityImageView)
        containerView.addSubview(priorityLabel)
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
            make.height.equalTo(60)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(containerView).inset(15)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.leading.equalTo(containerView).inset(15)
        }
        
        stageImageView.snp.makeConstraints { make in
            make.bottom.leading.equalTo(containerView).inset(15)
            make.width.height.equalTo(20)
        }
        
        stageLabel.snp.makeConstraints { make in
            make.leading.equalTo(stageImageView.snp.trailing).offset(6)
            make.bottom.equalTo(containerView).inset(15)
        }
        
        priorityImageView.snp.makeConstraints { make in
            make.trailing.equalTo(priorityLabel.snp.leading).offset(-2)
            make.centerY.equalTo(stageLabel.snp.centerY).inset(15)
            make.width.height.equalTo(26)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.trailing.equalTo(containerView).inset(15)
            make.bottom.equalTo(containerView).inset(15)
        }
    }
}
