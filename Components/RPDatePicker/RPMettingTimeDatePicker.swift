//
//  RPMettingTimeDatePicker.swift
//  TourApp
//
//  Created by Cagatay Ceker on 17.03.2024.
//

import UIKit

class RPMettingTimeDatePicker: UIView {
    
    var startTourTimeLabel: UILabel = {
        let view = UILabel()
        view.text = "Metting Time"
        view.textColor = .lightGray
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 16)
        return view
    }()
    
    private let chevronImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chevron"))
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let startTourTimeTextField: UITextField = {
        let view = UITextField()
        view.isHidden = true
        view.backgroundColor = .clear
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let noteIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "clock"))
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .time
        view.preferredDatePickerStyle = .wheels
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [startTourTimeLabel, dateLabel, startTourTimeTextField])
        view.axis = .vertical
        view.spacing = 2
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [noteIcon, verticalStackView, chevronImageView])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        setupDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        addSubview(horizontalStackView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        backgroundColor = .holderView
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            chevronImageView.widthAnchor.constraint(equalToConstant: 15),
            chevronImageView.heightAnchor.constraint(equalToConstant: 15),
            
            noteIcon.widthAnchor.constraint(equalToConstant: 30),
            noteIcon.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setupDatePicker() {
        startTourTimeTextField.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDoneButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        startTourTimeTextField.inputAccessoryView = toolbar
    }
    
    @objc private func showDatePicker() {
        startTourTimeTextField.becomeFirstResponder()
    }
    
    @objc private func didTapDoneButton() {
        let date = datePicker.date
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "HH:mm"
        let displayDate = displayDateFormatter.string(from: date)
        dateLabel.text = displayDate
        startTourTimeTextField.resignFirstResponder()
    }
}
