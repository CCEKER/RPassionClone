//
//  ParticipantTableViewCell.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import UIKit

class ParticipantTableViewCell: UITableViewCell {
    
    private let userNickname: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textColor = .white
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let userName: UILabel = {
        let view = UILabel()
        view.textColor = .gray
        view.font = UIFont.boldSystemFont(ofSize: 13)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let makerTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textColor = .systemBlue
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let carImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return view
    }()
    
    private let chevronIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chevron"))
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(equalToConstant: 15).isActive = true
        view.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [userNickname, userName, makerTitle])
        view.axis = .vertical
        view.spacing = 2
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [carImage, verticalStackView, chevronIcon])
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.backgroundColor = .background
        contentView.addSubview(horizontalStackView)
        contentView.addSubview(separatorView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
			horizontalStackView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -24),
			horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
			
			separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func reloadWith(_ viewModels: ParticipantsViewModel) {
        userNickname.text = viewModels.nickname
        userName.text = viewModels.userInfo
        makerTitle.text = viewModels.carMakerModelTrimTitle
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: viewModels.imageUrl)!), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.carImage.image = image
                }
            } else {
                self.carImage.image = UIImage(named: "porsche")
            }
        }
    }
}
