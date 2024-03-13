//
//  TourTimeDatePickerView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 13.03.2024.
//

import UIKit

protocol TourTimeDatePickerViewDelegate: AnyObject {
    func didSelectDatePicker(date: String)
}

class TourTimeDatePickerView: UIView {
    
    weak var delegate: TourTimeDatePickerViewDelegate?
    
    var startTourTimeLabel: UILabel = {
        let view = UILabel()
        view.text = "Tour Start Date"
        view.textColor = .lightGray
        view.font = UIFont.systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 16)
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
        let view = UIImageView(image: UIImage(named: "note"))
        view.contentMode = .scaleAspectFit
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
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        startTourTimeTextField.inputAccessoryView = toolbar
    }
    
    @objc private func showDatePicker() {
        startTourTimeTextField.becomeFirstResponder()
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "dd MMMM yyyy"
        let displayDate = displayDateFormatter.string(from: sender.date)
        dateLabel.text = displayDate
        
        let apiFormatter = DateFormatter()
        apiFormatter.dateFormat = "yyyy-MM-dd"
        let apiDate = apiFormatter.string(from: sender.date)
        delegate?.didSelectDatePicker(date: apiDate)
    }
    
    @objc private func dismissDatePicker() {
        startTourTimeTextField.resignFirstResponder()
    }
    
}
