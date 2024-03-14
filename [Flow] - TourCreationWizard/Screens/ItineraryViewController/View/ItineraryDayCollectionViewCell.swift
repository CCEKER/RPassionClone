//
//  ItineraryDayCollectionViewCell.swift
//  TourApp
//
//  Created by Cagatay Ceker on 14.03.2024.
//

import UIKit

class ItineraryDayCollectionViewCell: UICollectionViewCell {
    
    private let dayLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       setupViews()
        setupConstraints()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .holderView
        contentView.addSubview(dayLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func reloadWith(_ viewModel: ItineraryViewModel, isSelectedDay: Bool) {
        dayLabel.text = "Day \(viewModel.day)"
        self.contentView.backgroundColor = isSelectedDay ? UIColor.systemBlue: .holderView
        
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = frame.height / 2
    }
}
