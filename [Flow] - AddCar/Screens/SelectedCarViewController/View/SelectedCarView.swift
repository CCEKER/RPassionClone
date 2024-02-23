//
//  SelectedCarView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import UIKit

class SelectedCarView: UIView {
    
    private let carLogo: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let nickNameTextField: PrivateTextField = {
        let view = PrivateTextField()
        view.textColor = .white
        view.placeholder = "Give Your Car a Name"
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        view.leftViewMode = .always
        return view
    }()
    
    let makerHolderView: HolderView = {
        let view = HolderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabeL.text = "Brand"
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let makerModelHolderView: HolderView = {
        let view = HolderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabeL.text = "Model"
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let makerModelTrimHolderView: HolderView = {
        let view = HolderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabeL.text = "Trim"
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [makerHolderView, makerModelHolderView, makerModelTrimHolderView])
        view.axis = .vertical
        view.spacing = 8
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Save", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTextField()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .background
        addSubview(carLogo)
        addSubview(holderView)
        holderView.addSubview(nickNameTextField)
        addSubview(stackView)
        addSubview(saveButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            carLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            carLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            carLogo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            carLogo.heightAnchor.constraint(equalToConstant: 135),
            
            holderView.topAnchor.constraint(equalTo: carLogo.bottomAnchor, constant: 15),
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            holderView.heightAnchor.constraint(equalToConstant: 50),
            
            nickNameTextField.topAnchor.constraint(equalTo: holderView.topAnchor),
            nickNameTextField.leadingAnchor.constraint(equalTo: holderView.leadingAnchor),
            nickNameTextField.trailingAnchor.constraint(equalTo: holderView.trailingAnchor),
            nickNameTextField.bottomAnchor.constraint(equalTo: holderView.bottomAnchor),
            
            makerHolderView.heightAnchor.constraint(equalToConstant: 80),
            makerModelHolderView.heightAnchor.constraint(equalToConstant: 80),
            makerModelTrimHolderView.heightAnchor.constraint(equalToConstant: 80),
            
            stackView.topAnchor.constraint(equalTo: holderView.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupTextField() {
        nickNameTextField.delegate = self
    }
    
    func reloadWith(_ viewModels: SelectedCarViewModel) {
        makerHolderView.detailLabel.text = viewModels.makerTitle
        makerModelHolderView.detailLabel.text = viewModels.makerModelTitle
        makerModelTrimHolderView.detailLabel.text = viewModels.makerModelTrimTitle
        
        if let imageUrl = viewModels.imageUrl, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.carLogo.image = image
                    }
                }
            }
        } else {
            self.carLogo.image = UIImage(named: "porsche")
        }
    }
}

class PrivateTextField: UITextField {
    
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

extension SelectedCarView: UITextFieldDelegate {
    
}
