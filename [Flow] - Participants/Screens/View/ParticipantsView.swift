//
//  ParticipantsView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import UIKit

class ParticipantsView: UIView {
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.estimatedRowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.allowsSelection = true
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = false
        view.register(ParticipantTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let participantText: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 17)
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
        addSubview(participantText)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            participantText.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -25),
            participantText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    func reloadWith(totalParticipantStatus: String) {
        self.participantText.text = totalParticipantStatus
    }
}
