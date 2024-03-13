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
    
    let dayLabel: UILabel = {
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
    
    let tourTimeContinueButton: UIButton = {
        let view = UIButton(type: .custom)
        view.backgroundColor = .systemBlue
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
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
        addSubview(datePicker)
        addSubview(holderView)
        holderView.addSubview(questionLabel)
        holderView.addSubview(noteIcon)
        holderView.addSubview(buttonHolderView)
        buttonHolderView.addSubview(dayLabel)
        buttonHolderView.addSubview(minusButton)
        buttonHolderView.addSubview(leftSeperatorView)
        buttonHolderView.addSubview(plusButton)
        buttonHolderView.addSubview(rightSeperatorView)
        addSubview(tourTimeContinueButton)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            progressBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            progressBar.heightAnchor.constraint(equalToConstant: 10),
            
            datePicker.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            datePicker.heightAnchor.constraint(equalToConstant: 75),
            
            questionLabel.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 10),
            questionLabel.leadingAnchor.constraint(equalTo: noteIcon.trailingAnchor, constant: 10),
            questionLabel.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -20),
            
            buttonHolderView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
            buttonHolderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            buttonHolderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            buttonHolderView.heightAnchor.constraint(equalToConstant: 40),
            
            noteIcon.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 10),
            noteIcon.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 10),
            noteIcon.heightAnchor.constraint(equalToConstant: 30),
            noteIcon.widthAnchor.constraint(equalToConstant: 30),
            
            holderView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            holderView.heightAnchor.constraint(equalToConstant: 135),
            
            dayLabel.centerYAnchor.constraint(equalTo: buttonHolderView.centerYAnchor),
            dayLabel.centerXAnchor.constraint(equalTo: buttonHolderView.centerXAnchor),
            
            minusButton.leadingAnchor.constraint(equalTo: buttonHolderView.leadingAnchor),
            minusButton.topAnchor.constraint(equalTo: buttonHolderView.topAnchor),
            minusButton.bottomAnchor.constraint(equalTo: buttonHolderView.bottomAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 40),
            
            plusButton.trailingAnchor.constraint(equalTo: buttonHolderView.trailingAnchor, constant: -10),
            plusButton.topAnchor.constraint(equalTo: buttonHolderView.topAnchor),
            plusButton.bottomAnchor.constraint(equalTo: buttonHolderView.bottomAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 40),
            
            leftSeperatorView.topAnchor.constraint(equalTo: buttonHolderView.topAnchor, constant: 10),
            leftSeperatorView.bottomAnchor.constraint(equalTo: buttonHolderView.bottomAnchor, constant: -10),
            leftSeperatorView.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 10),
            leftSeperatorView.widthAnchor.constraint(equalToConstant: 1),
            
            rightSeperatorView.topAnchor.constraint(equalTo: buttonHolderView.topAnchor, constant: 10),
            rightSeperatorView.bottomAnchor.constraint(equalTo: buttonHolderView.bottomAnchor, constant: -10),
            rightSeperatorView.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -10),
            rightSeperatorView.widthAnchor.constraint(equalToConstant: 1),
            
            tourTimeContinueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tourTimeContinueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tourTimeContinueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tourTimeContinueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func reloadWith(_ viewModel: TourTimeViewModel) {
        questionLabel.text = viewModel.questionLabel
        tourTimeContinueButton.setTitle(viewModel.buttonTitle, for: .normal)
        dayLabel.text = viewModel.dayCountLabel
    }
}
