//
//  SelectedCarPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import Foundation

protocol SelectedCarPresenterProtocol {
    func presentSelectedCar(maker: Maker, makerModel: MakerModel, makerModelTrim: MakerModelTrim)
}

final class SelectedCarPresenter: SelectedCarPresenterProtocol {
    
    weak var viewController: SelectedCarViewControllerProtocol?
    
    func presentSelectedCar(maker: Maker, makerModel: MakerModel, makerModelTrim: MakerModelTrim) {
        let viewModels = SelectedCarViewModel(makerTitle: maker.title, makerModelTitle: makerModel.title, makerModelTrimTitle: makerModelTrim.title, imageUrl: maker.image)
        viewController?.displayViewState(.initial(viewModels))
    }
}
