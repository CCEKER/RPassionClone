//
//  MyGaragePresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation

protocol MyGaragePresenterProtocol {
    func presentLoading()
    func presentList(cars: [Car])
    func presentError()
}

final class MyGaragePresenter: MyGaragePresenterProtocol {
    
    weak var viewController: MyGarageViewControllerProtocol?
    
    func presentLoading() {
        viewController?.displayViewState(.loading)
    }
    
    func presentList(cars: [Car]) {
       
        if cars.isEmpty {
            let emptyViewModel = MyGarageEmptyViewModel(title: "Araba bulunamadı", description: "Araba yaratmak için butona tıklayın", actionButtonTitle: "Araba ekle")
            viewController?.displayViewState(.empty(emptyViewModel))
        } else {
            let viewModels = cars.map { car in
                CarTableViewCellModel(id: car.id, image: car.images.first, title: car.label, subTitle: car.nickname)
            }
            viewController?.displayViewState(.list(viewModels))
        }
    }
    
    func presentError() {
        let errorViewModel = ErrorViewModel(title: "Hata", description: "Bir hata oluştu", actionButtonTitle: "Tekrar Dene", cancelButtonTitle: "Kapat")
        viewController?.displayViewState(.error(errorViewModel))
    }
}
