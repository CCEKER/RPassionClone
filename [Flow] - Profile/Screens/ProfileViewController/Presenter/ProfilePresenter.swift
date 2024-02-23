//
//  ProfilePresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.01.2024.
//

import Foundation
import UIKit

protocol ProfilePresenterProtocol {
    func presentProfile(_ user: User)
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var viewController: ProfileViewControllerProtocol?
    
    func presentProfile(_ user: User) {
        
        
        let viewModels = ProfileViewModel(id: user.id, userName: user.username ?? "", firstName: user.firstName ?? "", lastName: user.lastName ?? "", profileImageUrl: user.profileImageUrl ?? "")
        viewController?.displayProfile(viewModels)
    }
}
