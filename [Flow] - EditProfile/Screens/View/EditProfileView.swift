//
//  EditProfileView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 2.03.2024.
//

import UIKit

class EditProfileView: UIView {
    
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
    
    private let datePickerHolderView: UIView = {
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
    
    let usernameTextField: CustomTextField = {
        let view = CustomTextField()
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
    
    let firstNameTextField: CustomTextField = {
        let view = CustomTextField()
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
    
    let lastNameTextField: CustomTextField = {
        let view = CustomTextField()
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
    
    let datePicker: UIDatePicker = {
       let view = UIDatePicker()
        view.datePickerMode = .date
    }()
    
    let instagramTextField: CustomTextField = {
        let view = CustomTextField()
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
    
    private lazy var stackView: UIStackView = {
       let view = UIStackView(arrangedSubviews: [usernameHolderView, firstNameHolderView, lastNameHolderView, datePickerHolderView, instagramHolderView])
        view.axis = .horizontal
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .background
        
        usernameHolderView.addSubview(usernameTextField)
        firstNameHolderView.addSubview(firstNameTextField)
        lastNameHolderView.addSubview(lastNameTextField)
        datePickerHolderView.addSubview(datePicker)
        instagramHolderView.addSubview(instagramTextField)
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        
    }
}
