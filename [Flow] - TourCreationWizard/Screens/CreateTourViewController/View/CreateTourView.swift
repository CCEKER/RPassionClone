//
//  CreateTourView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import UIKit

class CreateTourView: UIView {
    
    private let progressBar: RPProgressView = {
        let view = RPProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progress = 1
        return view
    }()
    
    private let tourNameHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let tourNameTextField: RPTextField = {
        let view = RPTextField()
        view.textColor = .white
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        return view
    }()
    
    var tourDescriptionTextView: UITextView = {
        let view = UITextView()
        view.textColor = .gray
        view.backgroundColor = .background
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        view.font = UIFont.systemFont(ofSize: 17)
        view.textAlignment = .left
        view.isEditable = true
        view.isSelectable = true
        view.isScrollEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [tourNameHolderView, tourDescriptionTextView])
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let continueButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 3
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tourNameTextField.delegate = self
        tourDescriptionTextView.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .background
        addSubview(progressBar)
        addSubview(tourNameHolderView)
        tourNameHolderView.addSubview(tourNameTextField)
        addSubview(tourDescriptionTextView)
        addSubview(stackView)
        addSubview(continueButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            progressBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            progressBar.heightAnchor.constraint(equalToConstant: 10),
            
            tourNameHolderView.heightAnchor.constraint(equalToConstant: 50),
            tourDescriptionTextView.heightAnchor.constraint(equalToConstant: 150),
            
            stackView.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func reloadWith(_ viewModel: CreateTourViewModel) {
        tourDescriptionTextView.text = viewModel.tourDescriptionText
        tourNameTextField.placeholder = viewModel.tourNameTextFieldPlaceHolder
        continueButton.setTitle(viewModel.continueButtonTitleLabel, for: .normal)
    }
}

extension CreateTourView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        resizeTextView(textView)
    }
    
    func resizeTextView(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}


extension CreateTourView: UITextFieldDelegate {
    
}
