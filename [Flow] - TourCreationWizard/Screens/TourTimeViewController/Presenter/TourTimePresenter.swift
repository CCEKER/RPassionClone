//
//  TourTimePresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 13.03.2024.
//

import Foundation

protocol TourTimePresenterProtocol {
    func presentUpdateDay(_ day: Int)
    func presentTourTimeScreen()
}

final class TourTimePresenter: TourTimePresenterProtocol {
    
    weak var viewController: TourTimeViewControllerProtocol?
    
    func presentUpdateDay(_ day: Int) {
        
        let viewModel = TourTimeViewModel(navigationTitle: "Tour Time",
                                          questionLabel: "How many days will the tour be?",
                                          dayCountLabel: "\(day) Days",
                                          buttonTitle: "Continue"
        )
        viewController?.displayViewModel(viewModel)
    }
    
    func presentTourTimeScreen() {
        let viewModel = TourTimeViewModel(navigationTitle: "Tour Time",
                                          questionLabel: "How many days will the tour be?",
                                          dayCountLabel: "",
                                          buttonTitle: "Continue"
        )
        viewController?.displayViewModel(viewModel)
    }
}
