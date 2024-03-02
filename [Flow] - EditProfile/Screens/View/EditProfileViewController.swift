//
//  EditProfileViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 2.03.2024.
//

import UIKit

protocol EditProfileViewControllerProtocol: AnyObject {
    
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
        
        customView.datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        self.title = "Edit My Profile"
    }
    
    @objc private func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateOfBirth = dateFormatter.string(from: datePicker.date)
    }
}

extension EditProfileViewController: EditProfileViewControllerProtocol {
    
}
