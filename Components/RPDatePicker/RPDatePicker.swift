//
//  RPDatePicker.swift
//  TourApp
//
//  Created by Cagatay Ceker on 3.03.2024.
//

import UIKit

protocol RPDatePickerProtocol: AnyObject {
    func didSelectDatePicker(date: String)
}

class RPDatePicker: UIView {
    
    weak var delegate: RPDatePickerProtocol?
    
    var dateOfBirthLabel: UILabel = {
        let view = UILabel()
        view.text = "Date Of Birth"
        view.textColor = .gray
        view.font = UIFont.systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let chevronImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chevron"))
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateOfBirthTextField: UITextField = {
        let view = UITextField()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels
        view.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
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
        setupViews()
        setupConstraints()
        setupDatePicker()
    }
    
    private func setupViews() {
        addSubview(dateOfBirthLabel)
        addSubview(chevronImageView)
        addSubview(dateOfBirthTextField)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        backgroundColor = .holderView
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            dateOfBirthLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            chevronImageView.widthAnchor.constraint(equalToConstant: 15),
            chevronImageView.heightAnchor.constraint(equalToConstant: 15),
            
            dateOfBirthTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateOfBirthTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setupDatePicker() {
        dateOfBirthTextField.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        dateOfBirthTextField.inputAccessoryView = toolbar
    }
    
    @objc private func showDatePicker() {
        dateOfBirthTextField.becomeFirstResponder()
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateOfBirthLabel.text = dateFormatter.string(from: sender.date)
        
        delegate?.didSelectDatePicker(date: dateFormatter.string(from: sender.date))
    }
    
    @objc private func dismissDatePicker() {
        dateOfBirthTextField.resignFirstResponder()
    }
    
}
