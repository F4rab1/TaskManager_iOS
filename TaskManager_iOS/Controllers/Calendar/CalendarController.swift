//
//  CalendarController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 25.07.2024.
//

import UIKit
import SnapKit

class CalendarController: UIViewController {
    
    let calendarHorizontalController = CalendarHorizontalController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.addSubview(calendarHorizontalController.view)
    }
    
    func setupConstraints() {
        calendarHorizontalController.view.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(120)
        }
    }

}
