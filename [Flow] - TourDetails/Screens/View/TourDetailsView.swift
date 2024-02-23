//
//  TourDetailsView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import UIKit

class TourDetailsView: UIView {
    
    private let tourDetailImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tourDetailTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 17)
        view.textColor = .white
        view.numberOfLines = 0
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let participantsLogo: UIImageView = {
        let view = UIImageView(image: UIImage(named: "participants"))
        view.contentMode = .scaleAspectFit
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return view
    }()
    
    private let participantsTitle: UILabel = {
        let view = UILabel()
        view.text = "Number of Participants"
        view.textColor = .gray
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        return view
    }()
    
    private let participantsSubtitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .natural
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    private let chevronIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chevron"))
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(equalToConstant: 15).isActive = true
        view.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return view
    }()
    
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = .holderView
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [participantsTitle, participantsSubtitle])
        view.axis = .vertical
        view.spacing = 5
        view.alignment = .fill
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [participantsLogo, verticalStackView, chevronIcon])
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .background
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TourDetailCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    
    private let makerLabel: UILabel = {
        let view = UILabel()
        view.text = "Participating Vehicle Brands"
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let invisibleButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
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
        addSubview(tourDetailImageView)
        addSubview(tourDetailTitle)
        addSubview(holderView)
        holderView.addSubview(horizontalStackView)
        holderView.addSubview(invisibleButton)
        addSubview(makerLabel)
        addSubview(collectionView)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            tourDetailImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            tourDetailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tourDetailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tourDetailImageView.heightAnchor.constraint(equalToConstant: 220),
            
            tourDetailTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tourDetailTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tourDetailTitle.topAnchor.constraint(equalTo: tourDetailImageView.bottomAnchor, constant: 20),
            
            holderView.topAnchor.constraint(equalTo: tourDetailTitle.bottomAnchor, constant: 15),
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            holderView.heightAnchor.constraint(equalToConstant: 70),
            
            horizontalStackView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 10),
            horizontalStackView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 15),
            horizontalStackView.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -15),
            horizontalStackView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -10),
            
            invisibleButton.topAnchor.constraint(equalTo: holderView.topAnchor),
            invisibleButton.leadingAnchor.constraint(equalTo: holderView.leadingAnchor),
            invisibleButton.trailingAnchor.constraint(equalTo: holderView.trailingAnchor),
            invisibleButton.bottomAnchor.constraint(equalTo: holderView.bottomAnchor),
        
            makerLabel.topAnchor.constraint(equalTo: holderView.bottomAnchor, constant: 40),
            makerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.topAnchor.constraint(equalTo: makerLabel.bottomAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            
        ])
    }
    
    func reloadWith(_ viewModels: TourDetailsViewModel) {
        
        tourDetailTitle.text = viewModels.title
        participantsSubtitle.text = "\(viewModels.participantsLimit) / \(viewModels.participantsJoined)"
       
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: viewModels.images[0])!), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.tourDetailImageView.image = image
                }
            }
        }
    }
}
