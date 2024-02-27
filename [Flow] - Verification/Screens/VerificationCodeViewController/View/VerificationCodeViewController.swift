//
//  VerificationCodeViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import UIKit

protocol VerificationCodeViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: VerificationCodeViewState)
}

class VerificationCodeViewController: UIViewController {
    
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
        
        self.title = "Enter Verification Code"
        
        customView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }
    
    @objc private func didTapConfirmButton() {
        
        guard let verificationCode = customView.otpTextField.text, !verificationCode.isEmpty else { return }
        interactor.didTapConfirmButton(verificationCode: verificationCode)
    }
}

extension VerificationCodeViewController: VerificationCodeViewControllerProtocol {
    
    func displayViewState(_ viewState: VerificationCodeViewState) {
        
        switch viewState {
        case .initial:
            break
        case .error(let error):
           showAlert(message: error)
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Verification code is invalid", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
