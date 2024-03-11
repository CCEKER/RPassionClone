//
//  CreateTourWelcomeView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import UIKit

class CreateTourWelcomeView: UIView {
    
    let closeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "closeButton"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.isEnabled = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 30)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = .white
        return view
    }()
    
    private let subtitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .center
        view.numberOfLines = 2
        view.textColor = .gray
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, subtitle])
        view.axis = .vertical
        view.spacing = 5
        view.alignment = .center
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let createTourImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startCreateTourButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 3
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .background
        addSubview(closeButton)
        addSubview(stackView)
        addSubview(createTourImageView)
        addSubview(startCreateTourButton)
        
        setupContraints()
    }
    
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            createTourImageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            createTourImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            createTourImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            createTourImageView.heightAnchor.constraint(equalToConstant: 350),
            
            startCreateTourButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            startCreateTourButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            startCreateTourButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startCreateTourButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func reloadWith(_ viewModel: CreateTourWelcomeViewModel) {
        titleLabel.text = viewModel.title
        subtitle.text = viewModel.subtitle
        createTourImageView.image = viewModel.image
        startCreateTourButton.setTitle(viewModel.createTourButtonTitle, for: .normal)
    }
}
