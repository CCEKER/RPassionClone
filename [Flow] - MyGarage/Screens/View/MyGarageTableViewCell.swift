//
//  MyGarageTableViewCell.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import UIKit

class MyGarageTableViewCell: UITableViewCell {
    
    private let cellImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let title: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Helvetica-Bold", size: 16)
        view.textColor = .white
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let carNickname: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 13)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [title, carNickname])
        view.axis = .vertical
        view.spacing = 3
        view.alignment = .fill
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [verticalStackView, chevronIcon])
        view.axis = .horizontal
        view.spacing = 5
        view.alignment = .leading
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let chevronIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chevron"))
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(equalToConstant: 15).isActive = true
        view.heightAnchor.constraint(equalToConstant: 15).isActive = true
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
        contentView.addSubview(cellImage)
        contentView.addSubview(horizontalStackView)
        contentView.addSubview(horizontalLineView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            cellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            cellImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
    
            horizontalStackView.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 18),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            horizontalStackView.bottomAnchor.constraint(equalTo: horizontalLineView.topAnchor, constant: -24),
            
            horizontalLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            horizontalLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            horizontalLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            horizontalLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func reloadWith(viewModel: CarTableViewCellModel) {
       
        title.text = viewModel.title
        carNickname.text = viewModel.subTitle

        if let imageUrl = viewModel.image, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.cellImage.image = image
                    }
                }
            }
        } else {
            self.cellImage.image = UIImage(named: "porsche")
        }
    }
}
