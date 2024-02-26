//
//  GarageView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import UIKit

class GarageView: UIView {
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .background
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.allowsSelection = true
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = false
        view.register(MyGarageTableViewCell.self, forCellReuseIdentifier: "cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let garageIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "emptyGarage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.isHidden = true
        return view
    }()
    
    let emptyLabel: UILabel = {
        let view = UILabel()
        view.text = "Garage Is Empty"
        view.font = UIFont.boldSystemFont(ofSize: 30)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = .white
        view.isHidden = false
        return view
    }()
    
    let emptySubtitle: UILabel = {
        let view = UILabel()
        view.text = "Add your cars, join the tours."
        view.textColor = .lightGray
        view.textAlignment = .center
        view.numberOfLines = 0
        view.isHidden = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [emptyLabel, emptySubtitle])
        view.axis = .vertical
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fill
        view.isHidden = true
        return view
    }()
    
    let addCarButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Add Car", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
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
        addSubview(garageIcon)
        addSubview(stackView)
        addSubview(addCarButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            garageIcon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70),
            garageIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 140),
            garageIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -140),
            garageIcon.heightAnchor.constraint(equalToConstant: 110),
            garageIcon.widthAnchor.constraint(equalToConstant: 110),
            
            stackView.topAnchor.constraint(equalTo: garageIcon.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            addCarButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            addCarButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addCarButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            addCarButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func displayEmptyView(show: Bool) {
        tableView.isHidden = show
        stackView.isHidden = !show
        addCarButton.isHidden = !show
    }
}
