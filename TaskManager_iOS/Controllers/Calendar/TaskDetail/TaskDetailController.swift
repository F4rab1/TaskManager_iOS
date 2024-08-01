//
//  TaskDetailController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 01.08.2024.
//

import UIKit
import SnapKit

class TaskDetailController: UIViewController {
    
    var task: Task! {
        didSet {
            titleTextField.text = task.title
            categoryTextField.text = task.category
            descriptionTextView.text = task.description
        }
    }
    
    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Title of the task"
        tf.borderStyle = .roundedRect
        tf.layer.borderColor = UIColor(red: 16, green: 94, blue: 245).cgColor
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 5.0
        
        return tf
    }()
    
    private let categoryTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Category of the task"
        tf.borderStyle = .roundedRect
        tf.layer.borderColor = UIColor(red: 16, green: 94, blue: 245).cgColor
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 5.0
        
        return tf
    }()
    
    private let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = true
        tv.layer.borderColor = UIColor(red: 16, green: 94, blue: 245).cgColor
        tv.layer.borderWidth = 1.0
        tv.layer.cornerRadius = 5.0
        
        return tv
    }()
    
    private lazy var mainStackView = CustomStackView(axis: .vertical, arrangedSubviews: [titleTextField, categoryTextField, descriptionTextView], spacing: 10, alignment: .fill)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        
        view.addSubview(mainStackView)
    }
    
    func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        [titleTextField, categoryTextField].forEach {
            $0.snp.makeConstraints { $0.height.equalTo(50)}
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
    }
    
}
