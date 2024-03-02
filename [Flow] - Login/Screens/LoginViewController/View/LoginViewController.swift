//
//  LoginViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    
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

		hideLoading()
        customView.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        customView.registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    @objc private func didTapRegisterButton() {
        interactor.didTapRegisterButton()
    }
    
    @objc private func didTapLoginButton() {
        
        guard let email = customView.emailTextField.text, !email.isEmpty else { return }
        guard let password = customView.passwordTextField.text, !password.isEmpty else { return }
    
		showLoading(viewModel: .init(caption: "Loading..."))
		interactor.didTapLoginButton(email: email, password: password)
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    
}
