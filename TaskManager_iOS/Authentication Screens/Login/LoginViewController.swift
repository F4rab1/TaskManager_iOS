//
//  LoginViewController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 31.08.2024.
//

import Foundation
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let contentView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
}
