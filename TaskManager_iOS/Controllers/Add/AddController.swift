//
//  AddController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 25.07.2024.
//

import UIKit
import SnapKit

class AddController: UIViewController {
    
    var selectedDate: String = ""
    var categories: [Category] = []
    var selectedCategoryID: Int?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Add Task"
        
        return label
    }()
    
    let startDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Date:"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        
        return label
    }()
    
    let startDateButton: UIButton = {
        let button = UIButton(type: .system)
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: today)
        button.setTitle(dateString, for: .normal)
        
        button.isEnabled = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = UIColor(red: 234, green: 255, blue: 255)
        button.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        
        return button
    }()

    let endDateLabel: UILabel = {
        let label = UILabel()
        label.text = "End Date:"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        
        return label
    }()

    let endDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("2030-01-01", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    let taskNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Task Name:"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        
        return label
    }()
    
    let taskNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter task name"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    let textTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        
        return label
    }()
    
    let taskTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        tv.layer.borderWidth = 0.5
        tv.layer.cornerRadius = 10
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        tv.isScrollEnabled = true
        tv.text = "Enter text of the Task here"
        tv.textColor = .lightGray
        
        return tv
    }()
    
    lazy var categoryPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .white
        
        return picker
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category:"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        
        return label
    }()

    let categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Category", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
        APIService.shared.fetchAndStoreCategories { [weak self] error in
            if let error = error {
                print("Failed to fetch categories: \(error)")
            } else {
                DispatchQueue.main.async {
                    if let categoryDict = UserDefaults.standard.dictionary(forKey: "categories") as? [String: String] {
                        self?.categories = categoryDict.map { Category(id: Int($0.key) ?? 0, title: $0.value) }
                        print("Loaded categories from UserDefaults: \(self?.categories ?? [])")
                    } else {
                        print("No categories available")
                    }
                }
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        endDateButton.addTarget(self, action: #selector(endDateButtonTapped), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(showCategoryPicker), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(startDateLabel)
        view.addSubview(endDateLabel)
        view.addSubview(startDateButton)
        view.addSubview(endDateButton)
        view.addSubview(taskNameLabel)
        view.addSubview(taskNameTextField)
        view.addSubview(textTaskLabel)
        view.addSubview(taskTextView)
        view.addSubview(categoryLabel)
        view.addSubview(categoryButton)
    }
    
    @objc func endDateButtonTapped() {
        let alertController = UIAlertController(title: "Select End Date", message: "\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 40, width: alertController.view.bounds.width - 120, height: 200)
        datePicker.locale = Locale(identifier: "en_US_POSIX")
        
        alertController.view.addSubview(datePicker)
        
        let selectAction = UIAlertAction(title: "Select", style: .default) { [self] _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            self.selectedDate = dateFormatter.string(from: datePicker.date)
            print(self.selectedDate)
            self.endDateButton.setTitle(selectedDate, for: .normal)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func showCategoryPicker() {
        let alertController = UIAlertController(title: "Select Category", message: "\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alertController.view.addSubview(categoryPicker)
        
        categoryPicker.snp.makeConstraints { make in
            make.top.equalTo(alertController.view.snp.top).offset(40)
            make.leading.trailing.equalTo(alertController.view).inset(20)
            make.height.equalTo(200)
        }
        
        let selectAction = UIAlertAction(title: "Select", style: .default) { [weak self] _ in
            let row = self?.categoryPicker.selectedRow(inComponent: 0) ?? 0
            let selectedCategory = self?.categories[row]
            self?.selectedCategoryID = selectedCategory?.id
            self?.categoryButton.setTitle(selectedCategory?.title, for: .normal)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        endDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.centerX).offset(10)
        }
        
        startDateButton.snp.makeConstraints { make in
            make.top.equalTo(startDateLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(50)
        }
        
        endDateButton.snp.makeConstraints { make in
            make.top.equalTo(endDateLabel.snp.bottom).offset(7)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        taskNameLabel.snp.makeConstraints { make in
            make.top.equalTo(startDateButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        taskNameTextField.snp.makeConstraints { make in
            make.top.equalTo(taskNameLabel.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        textTaskLabel.snp.makeConstraints { make in
            make.top.equalTo(taskNameTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        taskTextView.snp.makeConstraints { make in
            make.top.equalTo(textTaskLabel.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(170)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(taskTextView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
    }
    
}

extension AddController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].title
    }
}
