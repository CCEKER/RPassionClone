//
//  VerificationCodeViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import UIKit

protocol VerificationCodeViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: VerificationCodeViewState, remainingAttemp: Int)
    func displayResendVerificationCodeSuccess(viewModel: ResendVerificationCodeSuccessViewModel)
	func displayLoading(_ viewModel: RPLoadingViewModel)
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
        
        customView.delegate = self
        customView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        customView.resendCodeButton.addTarget(self, action: #selector(didTapResendCodeButton), for: .touchUpInside)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		hideLoading()
	}
    
    @objc private func didTapResendCodeButton() {
		interactor.didTapResendCodeButton()
    }
    
    @objc private func didTapConfirmButton() {
        guard let verificationCode = customView.otpTextField.text, !verificationCode.isEmpty else { return }
        interactor.didTapConfirmButton(verificationCode: verificationCode)
    }
	
	private func handleAlertCloseButtonAction(action: UIAlertAction) {
		hideLoading()
	}
}

extension VerificationCodeViewController: VerificationCodeViewControllerProtocol, VerificationViewDelegate {
    
    func displayViewState(_ viewState: VerificationCodeViewState, remainingAttemp: Int) {
        
        switch viewState {
        case .initial:
			hideLoading()
        case .error(let error):
			let message = "\(error) - \(remainingAttemp)"
			displayAlert(title: "Verification code is invalid", message: message, actionTitle: "Try Again!", action: handleAlertCloseButtonAction)
        }
    }
	
	func displayResendVerificationCodeSuccess(viewModel: ResendVerificationCodeSuccessViewModel) {
		customView.resendCodeButton.isHidden = viewModel.isResendCodeButtonHidden
		customView.timerLabel.isHidden = viewModel.isTimerLabelHidden
		customView.remainingSeconds = viewModel.remainingSeconds
		if viewModel.shouldTimerStart {
			customView.startTimer()
		}
		displayAlert(title: "Verification code has been resent", message: "Check \(viewModel.userEmail)", actionTitle: "OK", action: handleAlertCloseButtonAction)
		hideLoading()
	}

    func timerDidFinish() {
		displayAlert(title: "Time is up!", message: "Your time for entering the code has expired.", actionTitle: "OK", action: handleAlertCloseButtonAction)
    }
	
	func displayLoading(_ viewModel: RPLoadingViewModel) {
		showLoading(viewModel: viewModel)
	}
	
	private func displayAlert(title: String, message: String?, actionTitle: String, action: ((UIAlertAction) -> Void)?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: action))
		present(alert, animated: true)
	}
}
