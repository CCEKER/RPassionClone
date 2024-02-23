//
//  LoginView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import UIKit

class LoginView: UIView {
    
    private let logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "rpassion"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
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
    
    let emailTextField: CustomTextField = {
       let view = CustomTextField()
       view.textColor = .white
       view.placeholder = "Email"
       view.backgroundColor = .background
       view.layer.cornerRadius = 5
       view.layer.masksToBounds = true
       view.translatesAutoresizingMaskIntoConstraints = false
       view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
       view.layer.masksToBounds = true
       view.translatesAutoresizingMaskIntoConstraints = false
       view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
       return view
   }()
    
    let loginButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .systemBlue
        view.setTitle("Login", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [emailHolderView, passwordHolderView])
        view.spacing = 12
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
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
        addSubview(logoImageView)
        emailHolderView.addSubview(emailTextField)
        passwordHolderView.addSubview(passwordTextField)
        addSubview(stackView)
        addSubview(loginButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailHolderView.heightAnchor.constraint(equalToConstant: 50),
            passwordHolderView.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension LoginView: UITextFieldDelegate {
 
}

class CustomTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
       bounds.insetBy(dx: 10, dy: 15)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 15)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 15)
    }
}
