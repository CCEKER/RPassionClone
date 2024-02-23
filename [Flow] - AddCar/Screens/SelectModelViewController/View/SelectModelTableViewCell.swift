//
//  SelectModelTableViewCell.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import UIKit

class SelectModelTableViewCell: UITableViewCell {
    
    private let carsModelLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private let chevronIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chevron"))
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.5)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
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
        contentView.addSubview(carsModelLabel)
        contentView.addSubview(chevronIcon)
        contentView.addSubview(horizontalLineView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            carsModelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            carsModelLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20),
            carsModelLabel.bottomAnchor.constraint(lessThanOrEqualTo: horizontalLineView.topAnchor, constant: -20),
            carsModelLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            chevronIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            chevronIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronIcon.widthAnchor.constraint(equalToConstant: 15),
            chevronIcon.heightAnchor.constraint(equalToConstant: 15),
            
            horizontalLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            horizontalLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            horizontalLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func reloadWith(_ viewModel: SelectModelViewModel) {
        carsModelLabel.text = viewModel.title
    }
}
