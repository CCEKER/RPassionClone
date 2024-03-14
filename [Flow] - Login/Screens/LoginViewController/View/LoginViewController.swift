//
//  LoginViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func displayLoadingScreen(_ viewModel: RPLoadingViewModel)
	func displayState(_ state: LoginViewState)
}

class LoginViewController: UIViewController, RPLoadingDisplayable {
    
    private let interactor: LoginInteractorProtocol
    private let customView = LoginView()
    
    override func loadView() {
        view = customView
    }
    
    init(interactor: LoginInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        customView.registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideLoading()
    }
    
    @objc private func didTapRegisterButton() {
        interactor.didTapRegisterButton()
    }
    
    @objc private func didTapLoginButton() {
        
        guard let email = customView.emailTextField.text, !email.isEmpty else { return }
        guard let password = customView.passwordTextField.text, !password.isEmpty else { return }

		interactor.didTapLoginButton(email: email, password: password)
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    
    func displayLoadingScreen(_ viewModel: RPLoadingViewModel) {
        showLoading(viewModel: viewModel)
    }
	
	func displayState(_ state: LoginViewState) {
		switch state {
		case .initial:
			break
		case .loading:
			break
		case .error(let errorViewModel):
			hideLoading()
			let alertController = UIAlertController(title: errorViewModel.title, message: errorViewModel.description, preferredStyle: .alert)
			alertController.addAction(.init(title: errorViewModel.cancelButtonTitle, style: .cancel))
			self.present(alertController, animated: true)
		}
	}
}
