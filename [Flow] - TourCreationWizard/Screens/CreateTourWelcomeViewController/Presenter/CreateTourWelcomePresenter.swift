//
//  CreateTourWelcomePresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation
import UIKit

protocol CreateTourWelcomePresenterProtocol {
    func presentCreateTourWelcomeScreen()
}

final class CreateTourWelcomePresenter: CreateTourWelcomePresenterProtocol {
    
    weak var viewController: CreateTourWelcomeViewControllerProtocol?
    
    func presentCreateTourWelcomeScreen() {
        
        let viewModel = CreateTourWelcomeViewModel(title: "Tour Creation Wizard",
                                                   subtitle: "This wizard will help you create a tour step by step.",
                                                   image: UIImage(named: "createTour")!,
                                                   createTourButtonTitle: "Start Create Tour"
        )
        viewController?.displayCreateTourWelcomeScreen(.initial(viewModel))
    }
}
