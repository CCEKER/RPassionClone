//
//  HolderView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import UIKit

class HolderView: UIView {
    
    var didTapClear: (()-> Void)?

    let titleLabeL: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let editButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(named: "edit"), for: .normal)
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let clearButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clearButton.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
    
        setupView()
    }
    
    @objc func didTapClearButton() {
        didTapClear!()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
       
        backgroundColor = .holderView

        addSubview(titleLabeL)
        addSubview(detailLabel)
        addSubview(editButton)
        addSubview(clearButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
        
            titleLabeL.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabeL.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            detailLabel.topAnchor.constraint(equalTo: titleLabeL.bottomAnchor, constant: 5),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            editButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 30),
            editButton.heightAnchor.constraint(equalToConstant: 30),
            
            clearButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            clearButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            clearButton.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
