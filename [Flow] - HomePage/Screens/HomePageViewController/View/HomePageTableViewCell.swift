//
//  HomePageTableViewCell.swift
//  TourApp
//
//  Created by Cagatay Ceker on 5.01.2024.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {
    
    private let tourImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let tourTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Helvetica-Bold", size: 18)
        view.textColor = .white
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private let locationLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Roboto", size: 10)
        view.textColor = .lightGray
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private let locationIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon"))
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(equalToConstant: 18).isActive = true
        view.heightAnchor.constraint(equalToConstant: 18).isActive = true
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Helvetica-Bold", size: 15)
        view.textColor = .white
        view.numberOfLines = 0
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [tourTitleLabel, locationStackView])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var locationStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [locationIcon, locationLabel])
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.5)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let verticalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.5)
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
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
        contentView.addSubview(tourImageView)
        contentView.addSubview(labelStackView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(horizontalLineView)
        contentView.addSubview(verticalLineView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            tourImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            tourImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            tourImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            tourImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            labelStackView.topAnchor.constraint(equalTo: tourImageView.bottomAnchor, constant: 18),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            labelStackView.trailingAnchor.constraint(equalTo: verticalLineView.leadingAnchor, constant: -5),
            labelStackView.bottomAnchor.constraint(equalTo: horizontalLineView.topAnchor, constant: -24),
            
            verticalLineView.topAnchor.constraint(equalTo: tourImageView.bottomAnchor, constant: 18),
            verticalLineView.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -10),
            verticalLineView.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: tourImageView.bottomAnchor, constant: 18),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            dateLabel.widthAnchor.constraint(equalToConstant: 50),
            
            horizontalLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            horizontalLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            horizontalLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
    
     func reloadWith(_ homePageViewModel: HomePageViewModel) {
        
        tourTitleLabel.text = homePageViewModel.title
         locationLabel.text = homePageViewModel.description
         dateLabel.text = homePageViewModel.startDate
         
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: homePageViewModel.images[0])!), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.tourImageView.image = image
                }
            }
        }
    }
}
