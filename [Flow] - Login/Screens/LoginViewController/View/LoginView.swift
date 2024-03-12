//
//  LoginView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import UIKit

class LoginView: UIView {
    
    private let loginLabel: UILabel = {
        let view = UILabel()
        view.text = "Login"
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = .white
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let passwordHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris laoreet."
        view.numberOfLines = 2
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: RPTextField = {
        let view = RPTextField()
        view.textColor = .white
        view.placeholder = "Email"
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        return view
    }()
    
    let passwordTextField: RPTextField = {
        let view = RPTextField()
        view.textColor = .white
        view.placeholder = "Password"
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.isSecureTextEntry = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return view
    }()
    
    let forgotPasswordButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Forgot Password", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.backgroundColor = .background
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .systemBlue
        view.setTitle("Login", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    private let hintLabel: UILabel = {
        let view = UILabel()
        view.text = "Type a minimum of 8 characters"
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 12)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [emailHolderView, passwordHolderView, hintLabel])
        view.spacing = 12
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let registerTitle: UILabel = {
        let view = UILabel()
        view.text = "Don't have an account yet?"
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textColor = .white
        return view
    }()
    
    let registerButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Register!", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.backgroundColor = .background
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        return view
    }()
    
    private lazy var customStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [registerTitle, registerButton])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .background
        addSubview(titleLabel)
        addSubview(loginLabel)
        emailHolderView.addSubview(emailTextField)
        passwordHolderView.addSubview(passwordTextField)
        addSubview(forgotPasswordButton)
        addSubview(stackView)
        addSubview(loginButton)
        addSubview(customStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            loginLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -25),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            forgotPasswordButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: 200),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 50),
            
            emailHolderView.heightAnchor.constraint(equalToConstant: 50),
            passwordHolderView.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
            loginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            customStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            customStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            customStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -65),
            customStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.becomeFirstResponder()
        }
        return true
    }
}
