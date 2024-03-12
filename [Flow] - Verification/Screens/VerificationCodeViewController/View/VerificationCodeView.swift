//
//  VerificationCodeView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import UIKit

protocol VerificationViewDelegate: AnyObject {
    func timerDidFinish()
}

class VerificationCodeView: UIView {
    
    private var timer: Timer?
    var remainingSeconds: Int = 60
    weak var delegate: VerificationViewDelegate?
    
    private let title: UILabel = {
        let view = UILabel()
        view.text = "Please enter the confirmation code sent to your e-mail."
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textColor = .white
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let otpHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let otpTextField: RPTextField = {
        let view = RPTextField()
        view.textColor = .white
        view.placeholder = "Enter your verification code"
        view.textAlignment = .left
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        view.isSecureTextEntry = false
        view.layer.masksToBounds = true
        view.keyboardType = .numberPad
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return view
    }()
    
    let confirmButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Confirm", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var timerLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textAlignment = .natural
        view.numberOfLines = 0
        view.textColor = .white
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let resendCodeButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Resend Code", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.setTitleColor(.systemBlue, for: .normal)
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
        otpTextField.delegate = self
        backgroundColor = .background
        addSubview(title)
        addSubview(otpHolderView)
        otpHolderView.addSubview(otpTextField)
        addSubview(confirmButton)
        addSubview(timerLabel)
        addSubview(resendCodeButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            otpHolderView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            otpHolderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            otpHolderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            otpHolderView.heightAnchor.constraint(equalToConstant: 50),
            
            resendCodeButton.topAnchor.constraint(equalTo: otpHolderView.bottomAnchor, constant: 10),
            resendCodeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            timerLabel.topAnchor.constraint(equalTo: otpHolderView.bottomAnchor, constant: 10),
            timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            confirmButton.topAnchor.constraint(equalTo: resendCodeButton.bottomAnchor, constant: 15),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        updateTimerLabel()
    }
    
    @objc private func updateTimerLabel() {
        if remainingSeconds >= 0 {
            
            let fullText = "Time Remaining: "
            let time = String(format: "%02d:%02d", remainingSeconds / 60, remainingSeconds % 60)
            let attributedString = NSMutableAttributedString(string: fullText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let timeAttributedString = NSAttributedString(string: time, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
            attributedString.append(timeAttributedString)
            timerLabel.attributedText = attributedString
            remainingSeconds -= 1
        } else {
            timer?.invalidate()
            timer = nil
            delegate?.timerDidFinish()
        }
    }
}

extension VerificationCodeView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let textRange = Range(range, in: currentText), let replacedText = currentText.replacingCharacters(in: textRange, with: string) as String? else {
            return false
        }

        let newLength = replacedText.count
        return newLength <= 4
    }
}
