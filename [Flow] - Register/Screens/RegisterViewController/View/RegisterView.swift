//
//  RegisterView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import UIKit

class RegisterView: UIView {
    
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
        view.text = "Nam eu lacus in turpis molestie porttitor. Etiam odio justo, posuere quis elit eu."
        view.numberOfLines = 2
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: CustomTextField = {
        let view = CustomTextField()
        view.textColor = .white
        view.placeholder = "Email"
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardType = .emailAddress
        view.returnKeyType = .next
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        view.leftViewMode = .always
        return view
    }()
    
    let passwordTextField: CustomTextField = {
        let view = CustomTextField()
        view.textColor = .white
        view.placeholder = "Password"
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.isSecureTextEntry = true
        view.keyboardType = .default
        view.returnKeyType = .done
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return view
    }()
    
    let nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .systemBlue
        view.setTitle("Next", for: .normal)
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
    
    private let registeredTitle: UILabel = {
        let view = UILabel()
        view.text = "Do you have a registered acoount?"
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textColor = .white
        return view
    }()
    
    let backLoginButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Login!", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.backgroundColor = .background
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        return view
    }()
    
    private lazy var customStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [registeredTitle, backLoginButton])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        backgroundColor = .background
        addSubview(titleLabel)
        emailHolderView.addSubview(emailTextField)
        passwordHolderView.addSubview(passwordTextField)
        addSubview(stackView)
        addSubview(nextButton)
        addSubview(customStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailHolderView.heightAnchor.constraint(equalToConstant: 50),
            passwordHolderView.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
            nextButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            customStackView.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 15),
            customStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            customStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            customStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension RegisterView: UITextFieldDelegate {
    
}
