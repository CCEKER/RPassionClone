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
        view.text = "How many days will the tour be?"
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    private lazy var verticalStackView: UIStackView = {
//        let view = UIStackView(arrangedSubviews: [questionLabel, stepper, stepperLabel])
//        view.axis = .vertical
//        view.spacing = 5
//        view.alignment = .leading
//        view.distribution = .fill
//        return view
//    }()
//    
//    private lazy var horizontalStackView: UIStackView = {
//       let view = UIStackView(arrangedSubviews: [noteIcon, verticalStackView])
//        view.axis = .horizontal
//        view.distribution = .fill
//        view.alignment = .center
//        view.spacing = 10
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private let stepper: UIStepper = {
        let view = UIStepper()
        view.value = 1
        view.maximumValue = 7
        view.minimumValue = 1
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stepperLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints  = false
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
        holderView.addSubview(stepper)
        holderView.addSubview(stepperLabel)
        holderView.addSubview(questionLabel)
        holderView.addSubview(noteIcon)
        
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
    
        datePicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        stepperLabel.text = "\(Int(sender.value)) Days"
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
            
            
            
            noteIcon.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 10),
            noteIcon.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 10),
            noteIcon.heightAnchor.constraint(equalToConstant: 30),
            noteIcon.widthAnchor.constraint(equalToConstant: 30),
            
            holderView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            holderView.heightAnchor.constraint(equalToConstant: 135)
        ])
    }
}
