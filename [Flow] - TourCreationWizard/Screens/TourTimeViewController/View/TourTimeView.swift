//
//  TourTimeView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 13.03.2024.
//

import UIKit

protocol TourTimeViewProtocol: AnyObject {
    func didTapDatePickerDoneButton(date: String)
}

class TourTimeView: UIView, TourTimeDatePickerViewDelegate {
    
    private let datePicker = TourTimeDatePickerView()
    weak var delegate: TourTimeViewProtocol?
    
    private let progressBar: RPProgressView = {
        let view = RPProgressView()
        view.progress = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = .holderView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let noteIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "note"))
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let questionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dayCountLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 13)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private let buttonHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let minusButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "minus"), for: .normal)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let plusButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "plus"), for: .normal)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let leftSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rightSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [questionLabel, buttonHolderView])
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [noteIcon, verticalStackView])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonHolderStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [minusButton, leftSeperatorView, dayCountLabel, rightSeperatorView, plusButton])
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .equalCentering
        view.spacing = 8
        return view
    }()
    
    let tourTimeContinueButton: UIButton = {
        let view = UIButton(type: .custom)
        view.backgroundColor = .systemBlue
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    private lazy var holderStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [datePicker, holderView])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        datePicker.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func didSelectDatePicker(date: String) {
        delegate?.didTapDatePickerDoneButton(date: date)
    }
    
    private func setupViews() {
        backgroundColor = .background
        addSubview(progressBar)
        addSubview(holderStack)
        holderView.addSubview(horizontalStack)
        buttonHolderView.addSubview(buttonHolderStack)
        addSubview(tourTimeContinueButton)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            progressBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            progressBar.heightAnchor.constraint(equalToConstant: 10),
            
            holderStack.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 20),
            holderStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            holderStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            datePicker.heightAnchor.constraint(equalToConstant: 75),
            holderView.heightAnchor.constraint(equalToConstant: 135),
            
            buttonHolderView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
            buttonHolderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            buttonHolderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            buttonHolderView.heightAnchor.constraint(equalToConstant: 40),
            
            noteIcon.heightAnchor.constraint(equalToConstant: 30),
            noteIcon.widthAnchor.constraint(equalToConstant: 30),
            
            horizontalStack.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -20),
            horizontalStack.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 20),
            horizontalStack.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 20),
            horizontalStack.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -20),
            
            minusButton.widthAnchor.constraint(equalToConstant: 40),
            plusButton.widthAnchor.constraint(equalToConstant: 40),
            leftSeperatorView.widthAnchor.constraint(equalToConstant: 1),
            rightSeperatorView.widthAnchor.constraint(equalToConstant: 1),
            
            buttonHolderStack.topAnchor.constraint(equalTo: buttonHolderView.topAnchor, constant: 10),
            buttonHolderStack.leadingAnchor.constraint(equalTo: buttonHolderView.leadingAnchor, constant: 10),
            buttonHolderStack.trailingAnchor.constraint(equalTo: buttonHolderView.trailingAnchor, constant: -10),
            buttonHolderStack.bottomAnchor.constraint(equalTo: buttonHolderView.bottomAnchor, constant: -10),
            
            tourTimeContinueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tourTimeContinueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tourTimeContinueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tourTimeContinueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func reloadWith(_ viewModel: TourTimeViewModel) {
        questionLabel.text = viewModel.questionLabel
        tourTimeContinueButton.setTitle(viewModel.buttonTitle, for: .normal)
        dayCountLabel.text = viewModel.dayCountLabel
        minusButton.isEnabled = viewModel.isMinusButtonEnabled
        plusButton.isEnabled = viewModel.isPlusButtonEnabled
    }
}
