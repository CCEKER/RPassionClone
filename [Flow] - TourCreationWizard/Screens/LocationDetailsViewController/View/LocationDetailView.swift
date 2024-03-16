//
//  LocationDetailView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import UIKit

class LocationDetailView: UIView {
    
    let timePicker = RPMettingTimeDatePicker()
    
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    private let whiteLocationIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let locationTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textColor = .white
        view.numberOfLines = 0
        return view
    }()
    
    private let addressLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textColor = .white
        view.numberOfLines = 0
        return view
    }()
    
    private let chevronIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titlesStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [locationTitle, addressLabel])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 3
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [whiteLocationIcon, titlesStackView, chevronIcon])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let locationDetailsTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 25)
        view.textColor = .white
        view.numberOfLines = 0
        return view
    }()
    
    private let locationDetailsSubtitle: UILabel = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.numberOfLines = 2
        return view
    }()
    
    private let locationNameHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let locationNameTextField: RPTextField = {
        let view = RPTextField()
        view.textColor = .white
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        return view
    }()
    
    private lazy var ScreenStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [locationDetailsTitle, locationDetailsSubtitle, locationNameHolderView, timePicker])
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addLocationButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .systemBlue
        view.setTitleColor(.white, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        locationNameTextField.delegate = self
       
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .background
        addSubview(holderView)
        holderView.addSubview(horizontalStackView)
        locationNameHolderView.addSubview(locationNameTextField)
        addSubview(ScreenStackView)
        addSubview(addLocationButton)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            holderView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            holderView.heightAnchor.constraint(equalToConstant: 75),
            
            horizontalStackView.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -10),
            horizontalStackView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 10),
            horizontalStackView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 10),
            horizontalStackView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -10),
            
            whiteLocationIcon.heightAnchor.constraint(equalToConstant: 30),
            whiteLocationIcon.widthAnchor.constraint(equalToConstant: 30),
            
            chevronIcon.heightAnchor.constraint(equalToConstant: 15),
            chevronIcon.widthAnchor.constraint(equalToConstant: 15),
            
            timePicker.heightAnchor.constraint(equalToConstant: 75),
            locationNameHolderView.heightAnchor.constraint(equalToConstant: 50),
            
            ScreenStackView.topAnchor.constraint(equalTo: holderView.bottomAnchor, constant: 10),
            ScreenStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            ScreenStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            addLocationButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addLocationButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            addLocationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addLocationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func reloadWith(_ viewModel: LocationDetailViewModel) {
        whiteLocationIcon.image = viewModel.locationIcon
        locationTitle.text = viewModel.selectedLocationTitle
        addressLabel.text = viewModel.locationTtile
        chevronIcon.image = viewModel.chevronIcon
        locationDetailsTitle.text = viewModel.locationDetailsTitle
        locationDetailsSubtitle.text = viewModel.locationDetailsSubtitle
        locationNameTextField.placeholder = viewModel.textFieldPlaceHolder
        timePicker.startTourTimeLabel.text = viewModel.datePickerLabelText
        addLocationButton.setTitle(viewModel.addLocationButtonTitle, for: .normal)
    }
}

extension LocationDetailView: UITextFieldDelegate {
    
}
