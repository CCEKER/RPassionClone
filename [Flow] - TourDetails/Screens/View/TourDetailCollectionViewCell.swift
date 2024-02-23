//
//  TourDetailCollectionViewCell.swift
//  TourApp
//
//  Created by Cagatay Ceker on 9.02.2024.
//

import UIKit

class TourDetailCollectionViewCell: UICollectionViewCell {
    
    private let makerImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .holderView
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let makerLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 12)
        view.numberOfLines = 0
        view.textAlignment = .center
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
        contentView.backgroundColor = .background
        contentView.addSubview(contentHolderView)
        contentHolderView.addSubview(makerImageView)
        contentView.addSubview(makerLabel)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            contentHolderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            contentHolderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            contentHolderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contentHolderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
           
            makerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            makerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            makerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
    }
   
    func reloadWith(with maker: AllowedMakerViewModel) {
        
        makerLabel.text = maker.title
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: maker.image)!), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.makerImageView.image = image
                }
            }
        }
    }
}
