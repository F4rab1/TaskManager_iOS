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
    var viewModel: LoginProtocol
    
    init(viewModel: LoginProtocol) {
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
        contentView.loginButton.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
    }
    
    @objc func loginButton() {
        guard let username = contentView.usernameField.text, let password = contentView.passwordField.text else {
            return
        }
        
        viewModel.login(username: username, password: password)
        
        viewModel.loginResult = { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let vc = UINavigationController(rootViewController: BaseTabBarController())
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                }
            case .failure(let error):
                print("Login failed with error: \(error)")
            }
        }
    }
    
}
