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
    }
    
    @objc private func didTapLoginButton() {
        
        guard let email = customView.emailTextField.text else { return }
        guard let password = customView.passwordTextField.text else { return }
        
        interactor.didTapLoginButton(email: "cagatayceker@gmail.com", password: "A1%0000000")
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    
}
