//
//  SelectTrimPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import Foundation

protocol SelectTrimPresenterProtocol {
    func presentMakerModelTrim(_ makerModelTrim: [MakerModelTrim])
}

final class SelectTrimPresenter: SelectTrimPresenterProtocol {
    
    weak var viewController: SelectTrimViewControllerProtocol?
    
    func presentMakerModelTrim(_ makerModelTrim: [MakerModelTrim]) {
        
        let viewModels = makerModelTrim.map { trim in
            return TrimViewModel(title: trim.title, id: trim.id)
        }
        viewController?.displayViewState(.list(viewModels))
    }
}
