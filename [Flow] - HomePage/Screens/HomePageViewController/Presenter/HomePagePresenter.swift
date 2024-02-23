//
//  HomePagePresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 5.01.2024.
//

import Foundation

protocol HomePagePresenterProtocol {
    func presentTourList(_ tourList: HomePageModel)
}

final class HomePagePresenter: HomePagePresenterProtocol {
    
    weak var viewController: HomePageViewContollerProtocol?
    
    func presentTourList(_ tourList: HomePageModel) {
        
       let apiDateFormatter = DateFormatter()
        apiDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        apiDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "MMMM\ndd"
        displayDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let viewModels = tourList.list.map { tour in
            var dateLabel: String = "Unkown Date"
            if let date = apiDateFormatter.date(from: tour.startDate) {
                let displayDate = displayDateFormatter.string(from: date).uppercased()
                dateLabel = displayDate
            }
            return HomePageViewModel(id: tour.id, title: tour.title, description: tour.description, startDate: dateLabel, images: tour.images)
        }
        viewController?.displayView(viewModels: viewModels)
    }
}
