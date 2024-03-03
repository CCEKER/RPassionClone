//
//  EditProfileViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 2.03.2024.
//

import UIKit

protocol EditProfileViewControllerProtocol: AnyObject, RPLoadingDisplayable {
    
}

class EditProfileViewController: UIViewController {
    
    private let customView = EditProfileView()
    private let interactor: EditProfileInteractorProtocol
    
    init(interactor: EditProfileInteractorProtocol) {
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
        
        self.hideLoading()
        
        self.title = "Edit My Profile"
        
        customView.saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    @objc private func didTapSaveButton() {
       
        guard let username = customView.usernameTextField.text, !username.isEmpty else { return }
        guard let firstName = customView.firstNameTextField.text, !firstName.isEmpty else { return }
        guard let lastName = customView.lastNameTextField.text, !lastName.isEmpty else { return }
        guard let dateOfBirth = customView.rpDatePicker.dateOfBirthLabel.text, !dateOfBirth.isEmpty else { return }
        guard let countryCode = customView.countryTextField.text, !countryCode.isEmpty else { return }
        //guard let instagram = customView.instagramTextField.text, !instagram.isEmpty else { return }
        self.showLoading(viewModel: .init(caption: "Loading..."))
        
        interactor.editProfile(firstName: firstName, dateOfBirth: dateOfBirth, lastName: lastName, username: username, countrCode: countryCode)
    }
}

extension EditProfileViewController: EditProfileViewControllerProtocol {
    
}
