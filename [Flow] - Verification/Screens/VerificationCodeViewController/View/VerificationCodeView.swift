//
//  VerificationCodeView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import UIKit

class VerificationCodeView: UIView {
    
    private let title: UILabel = {
        let view = UILabel()
        view.text = "Please enter the confirmation code sent to your e-mail."
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textColor = .white
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let otpHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let otpTextField: CustomTextField = {
        let view = CustomTextField()
        view.textColor = .white
        view.placeholder = "Enter your verification code"
        view.textAlignment = .center
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.isSecureTextEntry = true
        view.layer.masksToBounds = true
        view.keyboardType = .numberPad
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return view
    }()
    
    let confirmButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Confirm", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 3
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
        otpTextField.delegate = self
        backgroundColor = .background
        addSubview(title)
        addSubview(otpHolderView)
        otpHolderView.addSubview(otpTextField)
        addSubview(confirmButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            otpHolderView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            otpHolderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            otpHolderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            otpHolderView.heightAnchor.constraint(equalToConstant: 50),
            
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            confirmButton.topAnchor.constraint(equalTo: otpHolderView.bottomAnchor, constant: 20),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension VerificationCodeView: UITextFieldDelegate {
    
}
