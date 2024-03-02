//
//  RegisterViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import UIKit

protocol RegisterViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: RegisterViewState)
}

class RegisterViewController: UIViewController, RPLoadingDisplayable {
    
    private let customView = RegisterView()
    private let interactor: RegisterInteractorProtocol
    
    init(interactor: RegisterInteractorProtocol) {
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
        
        self.title = "Register"
        
        customView.nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        customView.backLoginButton.addTarget(self, action: #selector(didTapBackLoginButton), for: .touchUpInside)
    }
    
    @objc private func didTapBackLoginButton() {
        interactor.didTapBackLoginButton()
    }
    
    @objc private func didTapNextButton() {
        
        guard let email = customView.emailTextField.text, !email.isEmpty else { return }
        guard let password = customView.passwordTextField.text, !password.isEmpty else { return }
        
        showLoading(viewModel: .init(caption: "Loading..."))
        interactor.didTapNextButton(email: email, password: password)
    }
}

extension RegisterViewController: RegisterViewControllerProtocol {
    
    func displayViewState(_ viewState: RegisterViewState) {
        switch viewState {
        
        case .initial:
            break
        
        case .error(let error):
            showAlert(message: error)
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Email is Already Registered", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
