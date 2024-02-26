//
//  RegisterViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import UIKit

protocol RegisterViewControllerProtocol: AnyObject {
    
}

class RegisterViewController: UIViewController {
    
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
    }
}

extension RegisterViewController: RegisterViewControllerProtocol {
    
}
