//
//  VerificationCodeViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import UIKit

protocol VerificationCodeViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: VerificationCodeViewState, remainingAttemp: Int)
    func displayResendCodeResult(success: Bool)
}

class VerificationCodeViewController: UIViewController, RPLoadingDisplayable {
    
    private let customView = VerificationCodeView()
    private let interactor: VerificationCodeInteractorProtocol
    
    init(interactor: VerificationCodeInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideLoading()
        
        self.title = "Enter Verification Code"
        customView.delegate = self
        
        customView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        customView.resendCodeButton.addTarget(self, action: #selector(didTapResendCodeButton), for: .touchUpInside)
    }
    
    @objc private func didTapResendCodeButton() {
        customView.timerLabel.isHidden = false
        customView.resendCodeButton.isHidden = true
        customView.remainingSeconds = 60
        customView.startTimer()
        interactor.didTapResendCodeButton()
    }
    
    @objc private func didTapConfirmButton() {
        
        guard let verificationCode = customView.otpTextField.text, !verificationCode.isEmpty else { return }
        showLoading(viewModel: .init(caption: "Loading..."))
        interactor.didTapConfirmButton(verificationCode: verificationCode)
    }
}

extension VerificationCodeViewController: VerificationCodeViewControllerProtocol, VerificationViewDelegate {
    
    func displayViewState(_ viewState: VerificationCodeViewState, remainingAttemp: Int) {
        
        switch viewState {
        case .initial:
            break
        case .error(let error):
           showAlert(message: "\(error)\(remainingAttemp)")
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Verification code is invalid", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func timerDidFinish() {
        let alert = UIAlertController(title: "Time is up!", message: "Your time for entering the code has expired.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func displayResendCodeResult(success: Bool) {
        
        if success {
            showAlert(message: "Verification Code Resent")
        } else {
            showAlert(message: "Failed to send verification code")
        }
    }
}
