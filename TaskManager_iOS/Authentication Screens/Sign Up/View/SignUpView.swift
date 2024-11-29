//
//  SignUpView.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 29.11.2024.
//

import Foundation
import UIKit
import SnapKit

class SignUpView: UIView {
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TaskLogo")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        label.text = "Let's sign up you"
        
        return label
    }()
    
    lazy var usernameField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        tf.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        tf.placeholder = "Create username"
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    lazy var passwordField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        tf.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        tf.placeholder = "Create password"
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        tf.rightView = passwordSecureButton
        tf.rightViewMode = .always
        
        
        return tf
    }()
    
    lazy var passwordSecureButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        let eyeOpenImage = UIImage(named: "eye")?.withRenderingMode(.alwaysOriginal)
        let eyeClosedImage = UIImage(named: "eyeClosed")?.withRenderingMode(.alwaysOriginal)
        
        configuration.image = eyeOpenImage
        configuration.imagePadding = 16
        configuration.imagePlacement = .trailing
        
        let button = UIButton(configuration: configuration)
        button.setImage(eyeClosedImage, for: .normal)
        button.addTarget(self, action: #selector(togglePasswordSecureEntry), for: .touchUpInside)
        
        return button
    }()
    
    lazy var emailField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        tf.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        tf.placeholder = "Your email"
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    lazy var firstNameField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        tf.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        tf.placeholder = "Your firstname"
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    lazy var lastNameField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        tf.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        tf.placeholder = "Your lastname"
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 23, green: 162, blue: 184)
        button.layer.cornerRadius = 8
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    
    private lazy var lineLeft: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 23, green: 162, blue: 184)
        
        return view
    }()
    
    private lazy var lineRight: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 23, green: 162, blue: 184)
        
        return view
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        label.text = "or"
        
        return label
    }()
    
    lazy var signUpGoogleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up with Google", for: .normal)
        button.setTitleColor(UIColor(red: 23, green: 162, blue: 184), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        
        return button
    }()
    
    private lazy var googleIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "google")
        
        return image
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Have account?"
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor(red: 23, green: 162, blue: 184), for: .normal)

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .white
        
        addSubview(logoImage)
        addSubview(signInLabel)
        addSubview(usernameField)
        addSubview(passwordField)
        addSubview(emailField)
        addSubview(firstNameField)
        addSubview(lastNameField)
        addSubview(signUpButton)
        addSubview(lineLeft)
        addSubview(orLabel)
        addSubview(lineRight)
        addSubview(signUpGoogleButton)
        addSubview(googleIcon)
        addSubview(loginLabel)
        addSubview(loginButton)
    }
    
    @objc private func togglePasswordSecureEntry(sender: UIButton) {
        passwordField.isSecureTextEntry.toggle()
        let imageName = passwordField.isSecureTextEntry ? "eyeClosed" : "eye"
        sender.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func setupConstraints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.height.width.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
        signInLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(-30)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(15)
        }
        
        usernameField.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(usernameField.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        firstNameField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        lastNameField.snp.makeConstraints { make in
            make.top.equalTo(firstNameField.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(lastNameField.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(14)
            make.height.equalTo(50)
        }

        lineLeft.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(self.snp.centerX).offset(-20)
            make.height.equalTo(1)
        }

        lineRight.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(self.snp.centerX).offset(20)
            make.height.equalTo(1)
        }

        orLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(lineLeft.snp.centerY).offset(-2)
        }
        
        signUpGoogleButton.snp.makeConstraints { make in
            make.top.equalTo(lineLeft.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        googleIcon.snp.makeConstraints { make in
            make.top.equalTo(signUpGoogleButton.snp.top).inset(12)
            make.leading.equalTo(signUpGoogleButton.snp.leading).inset(16)
            make.width.equalTo(26)
            make.bottom.equalTo(signUpGoogleButton.snp.bottom).inset(12)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(75)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.equalTo(loginLabel.snp.trailing).offset(10)
            make.centerY.equalTo(loginLabel.snp.centerY)
        }
        
    }
    
}

