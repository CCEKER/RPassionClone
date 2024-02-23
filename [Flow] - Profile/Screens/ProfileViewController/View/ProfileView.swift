//
//  ProfileView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.01.2024.
//

import UIKit

class ProfileView: UIView {
    
    private let holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let profileIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileUsername: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = .white
        view.numberOfLines = 0
        return view
    }()
    
    let profileFirstName: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 13)
        view.textColor = .lightGray
        view.numberOfLines = 0
        return view
    }()
    
    let profileLastName: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 13)
        view.textColor = .lightGray
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var profileNamesStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [profileFirstName, profileLastName])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 4
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [profileUsername, profileNamesStackView])
        view.spacing = 4
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let editButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "edit"), for: .normal)
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
        addSubview(holderView)
        holderView.addSubview(profileIcon)
        holderView.addSubview(stackView)
        holderView.addSubview(editButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            holderView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            holderView.heightAnchor.constraint(equalToConstant: 50),
            
            profileIcon.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 10),
            profileIcon.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 10),
            profileIcon.bottomAnchor.constraint(equalTo: holderView.bottomAnchor,constant: -10),
            profileIcon.widthAnchor.constraint(equalToConstant: 60),
            
            stackView.topAnchor.constraint(equalTo: holderView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: profileIcon.trailingAnchor, constant: 10),
            
            editButton.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 10),
            editButton.trailingAnchor.constraint(equalTo: holderView.trailingAnchor),
            editButton.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -10),
        ])
    }
    
    func reloadWith(viewModels: ProfileViewModel) {
        
        profileUsername.text = viewModels.userName
        profileFirstName.text = viewModels.firstName
        profileLastName.text =  viewModels.lastName
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: viewModels.profileImageUrl)!), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileIcon.image = image
                }
            }
        }
    }
}
