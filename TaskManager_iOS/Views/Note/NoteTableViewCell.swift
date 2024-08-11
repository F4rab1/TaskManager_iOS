//
//  NoteTableViewCell.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 11.08.2024.
//

import UIKit
import SnapKit

class NoteTableViewCell: UITableViewCell {
 
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
        label.text = "Text"
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(textOfNoteLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView).inset(16)
        }
        
        textOfNoteLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(16)
            make.leading.trailing.bottom.equalTo(contentView).inset(16)
        }
    }
    
}
