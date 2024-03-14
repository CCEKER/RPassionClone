//
//  ItineraryView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 14.03.2024.
//

import UIKit

class ItineraryView: UIView {
    
    private let progressBar: RPProgressView = {
        let view = RPProgressView()
        view.progress = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ItineraryDayCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    
    private let startPointHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .holderView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startPointTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .natural
        view.numberOfLines = 0
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startPointSubtitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textAlignment = .natural
        view.numberOfLines = 2
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startPointAddButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "addButton"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let videoCircleIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "video-circle"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var startPointStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [startPointTitle, startPointSubtitle])
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    private lazy var startPointVerticalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [videoCircleIcon, startPointStackView, startPointAddButton])
        view.axis = .horizontal
        view.alignment = .top
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let endPointHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .holderView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let endPointLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .natural
        view.numberOfLines = 0
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let endPointSubtitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textAlignment = .natural
        view.numberOfLines = 2
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let endPointIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "endPoint"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let endPointAddButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "addButton"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var endPointStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [endPointLabel, endPointSubtitleLabel])
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    private lazy var endPointVerticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [endPointIcon, endPointStackView, endPointAddButton])
        view.axis = .horizontal
        view.alignment = .top
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let helperText: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.numberOfLines = 2
        view.textColor = .gray
        return view
    }()
    
    private lazy var holderStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [startPointHolderView, endPointHolderView, helperText])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let itineraryContinueButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 3
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let skipButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .clear
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [itineraryContinueButton, skipButton])
        view.axis = .vertical
        view.spacing = 5
        view.alignment = .fill
        view.distribution = .fill
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
        backgroundColor = .background
        addSubview(progressBar)
        addSubview(collectionView)
        startPointHolderView.addSubview(startPointVerticalStack)
        endPointHolderView.addSubview(endPointVerticalStackView)
        addSubview(holderStackView)
        addSubview(buttonStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            progressBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            progressBar.heightAnchor.constraint(equalToConstant: 10),
            
            collectionView.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.heightAnchor.constraint(equalToConstant: 40),
            
            holderStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            holderStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            holderStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            startPointHolderView.heightAnchor.constraint(equalToConstant: 100),
            
            startPointVerticalStack.topAnchor.constraint(equalTo: startPointHolderView.topAnchor, constant: 10),
            startPointVerticalStack.bottomAnchor.constraint(equalTo: startPointHolderView.bottomAnchor, constant: -10),
            startPointVerticalStack.leadingAnchor.constraint(equalTo: startPointHolderView.leadingAnchor, constant: 10),
            startPointVerticalStack.trailingAnchor.constraint(equalTo: startPointHolderView.trailingAnchor, constant: -10),
            
            startPointAddButton.widthAnchor.constraint(equalToConstant: 50),
            videoCircleIcon.widthAnchor.constraint(equalToConstant: 27),
            
            endPointHolderView.heightAnchor.constraint(equalToConstant: 100),
            
            endPointVerticalStackView.topAnchor.constraint(equalTo: endPointHolderView.topAnchor, constant: 10),
            endPointVerticalStackView.bottomAnchor.constraint(equalTo: endPointHolderView.bottomAnchor, constant: -10),
            endPointVerticalStackView.leadingAnchor.constraint(equalTo: endPointHolderView.leadingAnchor, constant: 10),
            endPointVerticalStackView.trailingAnchor.constraint(equalTo: endPointHolderView.trailingAnchor, constant: -10),
            
            endPointAddButton.widthAnchor.constraint(equalToConstant: 50),
            endPointIcon.widthAnchor.constraint(equalToConstant: 27),
            
            buttonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonStackView.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: 20),
        
            itineraryContinueButton.heightAnchor.constraint(equalToConstant: 50),
            skipButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
