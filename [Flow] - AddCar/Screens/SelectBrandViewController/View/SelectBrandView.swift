//
//  SelectBrandView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import UIKit

class SelectBrandView: UIView {
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.estimatedRowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.allowsSelection = true
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = false
        view.register(SelectionsTableViewCell.self, forCellReuseIdentifier: "Cell")
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
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
