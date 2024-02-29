//
//  LoginViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    
}

class LoginViewController: UIViewController {
    
    private let interactor: LoginInteractorProtocol
    private let customView = LoginView()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
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
    
    @objc private func didTapRegisterButton() {
        interactor.didTapRegisterButton()
    }
    
    @objc private func didTapLoginButton() {
        
        guard let email = customView.emailTextField.text else { return }
        guard let password = customView.passwordTextField.text else { return }
        
        interactor.didTapLoginButton(email: email, password: password)
        showActivity()
    }
    func showActivity() {
        activityIndicator.center = self.view.center
        activityIndicator.color = .blue
        activityIndicator.alpha = 2.0
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    
}
