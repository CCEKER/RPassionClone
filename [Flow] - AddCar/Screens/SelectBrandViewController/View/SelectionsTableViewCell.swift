//
//  SelectionsTableViewCell.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import UIKit

class SelectionsTableViewCell: UITableViewCell {
    
    private let carBrandIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let carsBrandLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 16)
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
        contentView.addSubview(carBrandIcon)
        contentView.addSubview(carsBrandLabel)
        contentView.addSubview(chevronIcon)
        contentView.addSubview(horizontalLineView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            carBrandIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            carBrandIcon.widthAnchor.constraint(equalToConstant: 60),
            carBrandIcon.heightAnchor.constraint(equalToConstant: 60),
            carBrandIcon.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            carBrandIcon.bottomAnchor.constraint(lessThanOrEqualTo: horizontalLineView.topAnchor, constant: -10),
            carBrandIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            carsBrandLabel.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 10),
            carsBrandLabel.leadingAnchor.constraint(equalTo: carBrandIcon.trailingAnchor, constant: 10),
            carsBrandLabel.bottomAnchor.constraint(lessThanOrEqualTo: horizontalLineView.topAnchor, constant: -10),
            carsBrandLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            chevronIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            chevronIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronIcon.widthAnchor.constraint(equalToConstant: 15),
            chevronIcon.heightAnchor.constraint(equalToConstant: 15),
            
            horizontalLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            horizontalLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            horizontalLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func reloadWith(carBrand: SelectionTableViewCellModel) {
        carsBrandLabel.text = carBrand.title
        
        if let imageUrl = carBrand.image, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.carBrandIcon.image = image
                    }
                }
            }
        } else {
            self.carBrandIcon.image = UIImage(named: "porsche")
        }
    }
}
