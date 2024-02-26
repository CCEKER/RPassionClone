//
//  WelcomeView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.02.2024.
//

import UIKit

class WelcomeView: UIView {
    
    private let backgroundView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgorundImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.frame = UIScreen.main.bounds
        view.image = UIImage(named: "backimage")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let startButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .systemBlue
        view.setTitle("Start", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
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
        backgroundColor = .background
        addSubview(backgorundImage)
        addSubview(backgroundView)
        addSubview(logoImage)
        addSubview(startButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            backgorundImage.topAnchor.constraint(equalTo: topAnchor),
            backgorundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgorundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgorundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            
            startButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
