//
//  NoteTableViewCell.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 11.08.2024.
//

import UIKit
import SnapKit

class NoteTableViewCell: UITableViewCell {
    
    private let shadowContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 237, green: 242, blue: 246)
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(red: 211, green: 211, blue: 211).cgColor
        view.layer.borderWidth = 0.5
        view.layer.masksToBounds = true
        return view
    }()
 
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Title"
        return label
    }()
    
    let textOfNoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Text"
        label.numberOfLines = 2
        return label
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
        containerView.addSubview(titleLabel)
        containerView.addSubview(textOfNoteLabel)
    }
    
    func setupConstraints() {
        shadowContainerView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(8)
            make.leading.trailing.equalTo(contentView).inset(12)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(shadowContainerView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(containerView).inset(16)
        }
        
        textOfNoteLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(containerView).inset(16)
        }
    }
    
}
