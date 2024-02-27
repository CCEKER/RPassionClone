//
//  ProfileViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.01.2024.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    func displayProfile(_ viewModels: ProfileViewModel)
}

class ProfileViewController: UIViewController {
    
    private let interactor: ProfileInteractorProtocol
    private let customView = ProfileView()
    private var profileViewModels: ProfileViewModel?
    
    override func loadView() {
        view = customView
    }
    
    init(interactor: ProfileInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogoutButton))
        navigationItem.rightBarButtonItem = logoutButton
        
        interactor.fethUserProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.title = "Login"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    @objc private func didTapLogoutButton() {
        interactor.didTapLogoutButton()
    }
}

extension ProfileViewController: ProfileViewControllerProtocol {
   
    func displayProfile(_ viewModels: ProfileViewModel) {
        self.profileViewModels = viewModels
        customView.reloadWith(viewModel: viewModels)
    }
}
