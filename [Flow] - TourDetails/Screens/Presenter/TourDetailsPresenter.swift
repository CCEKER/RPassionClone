//
//  TourDetailsPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import Foundation

protocol TourDetailsPresenterProtocol {
    func presentTourDetail(_ tourDetail: TourDetailModel)
}

final class TourDetailsPresenter: TourDetailsPresenterProtocol {
    
    weak var viewController: TourDetailsViewControllerProtocol?
    
    func presentTourDetail(_ tourDetail: TourDetailModel) {
        
        let apiDateFormatter = DateFormatter()
        apiDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        apiDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "d MMMM yyyy - HH:mm"
        displayDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let startDate = apiDateFormatter.date(from: tourDetail.startDate), let lastRegistartionDate = apiDateFormatter.date(from: tourDetail.lastRegistrationDate) {
            let displayStartDate = displayDateFormatter.string(from: startDate)
            let displayLastRegistrationDate = displayDateFormatter.string(from: lastRegistartionDate)
            
            let allowedMakersViewModels = tourDetail.allowedMakers.map { maker in
                AllowedMakerViewModel(id: maker.id, title: maker.title, image: maker.image)
            }
            
            let viewModels = TourDetailsViewModel(id: tourDetail.id, title: tourDetail.title , startDate: displayStartDate, images: tourDetail.images, lastRegistrationDate: displayLastRegistrationDate, allowedMakers: allowedMakersViewModels, participantsLimit: tourDetail.participantsLimit, participantsJoined: tourDetail.participantsJoined)
            viewController?.displayTourDetail(viewModels)
        }
    }
}
