//
//  HomePageView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 5.01.2024.
//

import UIKit

class HomePageView: UIView {
    
    private let logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "rpassion"))
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let locationLabel: UILabel = {
        let view = UILabel()
        view.text = "Location, Netherlands"
        view.font = UIFont(name: "Roboto", size: 14)
        view.textColor = .lightGray
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [logoImageView, locationLabel])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .leading
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.estimatedRowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.allowsSelection = true
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = false
        view.register(HomePageTableViewCell.self, forCellReuseIdentifier: "Cell")
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
        addSubview(stackView)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

