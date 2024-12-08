//
//  AddController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 25.07.2024.
//

import UIKit
import SnapKit

class AddController: UIViewController {
    
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
        dateFormatter.dateFormat = "MMM-dd-yyyy"
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
        button.setTitle("Feb-22-2024", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        endDateButton.addTarget(self, action: #selector(endDateButtonTapped), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(startDateLabel)
        view.addSubview(endDateLabel)
        view.addSubview(startDateButton)
        view.addSubview(endDateButton)
    }
    
    @objc func endDateButtonTapped() {
        let alertController = UIAlertController(title: "Select End Date", message: "\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 40, width: alertController.view.bounds.width - 120, height: 200)
        datePicker.locale = Locale(identifier: "en_US_POSIX")
        
        alertController.view.addSubview(datePicker)
        
        let selectAction = UIAlertAction(title: "Select", style: .default) { _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM-dd-yyyy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let selectedDate = dateFormatter.string(from: datePicker.date)
            self.endDateButton.setTitle(selectedDate, for: .normal)
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
    }
    
}
