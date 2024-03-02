//
//  EditProfileView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 2.03.2024.
//

import UIKit

class EditProfileView: UIView {
    
    private let profileImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "defaultProfile"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let usernameHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let firstNameHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let lastNameHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let instagramHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let dateOfBirthHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let countryCodeHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let usernameTextField: CustomTextField = {
        let view = CustomTextField()
        view.textColor = .white
        view.placeholder = "Username"
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        return view
    }()
    
    let firstNameTextField: CustomTextField = {
        let view = CustomTextField()
        view.textColor = .white
        view.placeholder = "First Name"
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        return view
    }()
    
    let lastNameTextField: CustomTextField = {
        let view = CustomTextField()
        view.textColor = .white
        view.placeholder = "Last Name"
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        return view
    }()
    
    let dateOfBirthTextField: CustomTextField = {
        let view = CustomTextField()
        view.textColor = .white
        view.placeholder = "Date Of Birth"
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        return view
    }()
    
    let countryTextField: CustomTextField = {
        let view = CustomTextField()
        view.textColor = .white
        view.placeholder = "Country Code"
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        return view
    }()
    
    let instagramTextField: CustomTextField = {
        let view = CustomTextField()
        view.textColor = .white
        view.placeholder = "instagram"
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        return view
    }()
    
    private lazy var stackView: UIStackView = {
       let view = UIStackView(arrangedSubviews: [usernameHolderView, firstNameHolderView, lastNameHolderView, dateOfBirthHolderView, countryCodeHolderView, instagramHolderView])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .systemBlue
        view.setTitle("Save", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDelegate()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .background
        addSubview(profileImageView)
        usernameHolderView.addSubview(usernameTextField)
        firstNameHolderView.addSubview(firstNameTextField)
        lastNameHolderView.addSubview(lastNameTextField)
        instagramHolderView.addSubview(instagramTextField)
        dateOfBirthHolderView.addSubview(dateOfBirthTextField)
        countryCodeHolderView.addSubview(countryTextField)
        addSubview(stackView)
        addSubview(saveButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            
            usernameHolderView.heightAnchor.constraint(equalToConstant: 50),
            firstNameHolderView.heightAnchor.constraint(equalToConstant: 50),
            lastNameHolderView.heightAnchor.constraint(equalToConstant: 50),
            instagramHolderView.heightAnchor.constraint(equalToConstant: 50),
            dateOfBirthHolderView.heightAnchor.constraint(equalToConstant: 50),
            countryCodeHolderView.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 35),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
            saveButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupDelegate() {
        lastNameTextField.delegate = self
        firstNameTextField.delegate = self
        dateOfBirthTextField.delegate = self
        instagramTextField.delegate = self
        usernameTextField.delegate = self
        countryTextField.delegate = self
    }
}

extension EditProfileView: UITextFieldDelegate {
    
}
