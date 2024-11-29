//
//  SignUpController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 29.11.2024.
//

import UIKit
import SnapKit

class SignUpController: UIViewController {
    
    private let contentView = SignUpView()
    var viewModel: SignUpProtocol
    
    init(viewModel: SignUpProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addTargets()
    }
    
    func setupView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        contentView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        contentView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func signUpButtonTapped() {
        print("signUp")
        guard let username = contentView.usernameField.text, let password = contentView.passwordField.text, let email = contentView.emailField.text, let first_name = contentView.firstNameField.text, let last_name = contentView.lastNameField.text else {
            return
        }

        viewModel.register(username: username, password: password, email: email, first_name: first_name, last_name: last_name)

        viewModel.registerResult = { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                print("Login failed with error: \(error)")
            }
        }
    }
    
    @objc func loginButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

