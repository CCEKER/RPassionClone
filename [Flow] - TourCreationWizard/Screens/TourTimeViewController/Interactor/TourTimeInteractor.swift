//
//  TourTimeInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 13.03.2024.
//

import Foundation

protocol TourTimeInteractorProtocol {
    func didTapDatePickerDoneButton(date: String)
    func viewDidLoad()
    func decrementDay()
    func incrementDay()
}

protocol TourTimeInteractorCoordinatorDelegate: AnyObject {

}

final class TourTimeInteractor {
    
    private let presenter: TourTimePresenterProtocol
    weak var coordinator: TourTimeInteractorCoordinatorDelegate?
    private let tourService: TourServiceProtocol
    private let tourId: String
    private var count = 0
    
    init(presenter: TourTimePresenterProtocol, tourId: String, tourService: TourServiceProtocol) {
        self.presenter = presenter
        self.tourId = tourId
        self.tourService = tourService
    }
}

extension TourTimeInteractor: TourTimeInteractorProtocol {
    
    func didTapDatePickerDoneButton(date: String) {
        
        tourService.startDay(startDay: date, tourId: tourId) { result in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        }
    }
    
    func decrementDay() {
        if count > 1 {
            count -= 1
            presenter.presentUpdateDay(count)
        }
    }
    
    func incrementDay() {
        if count < 7 {
            count += 1
            presenter.presentUpdateDay(count)
        }
    }
    
    func viewDidLoad() {
        presenter.presentTourTimeScreen()
    }
}
