//
//  ItineraryInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 14.03.2024.
//

import Foundation

protocol ItineraryInteractorProtocol {
    func viewDidLoad()
    func didSelectDay(at index: Int)
    func didTapAddButton()
}

protocol ItineraryInteractorCoordinatorDelegate: AnyObject {
    func itineraryInteractorDidTapAddButton()
}

final class ItineraryInteractor {
    
    private let presenter: ItineraryPresenterProtocol
    weak var coordinator: ItineraryInteractorCoordinatorDelegate?
    private let tourId: String
    private let tourService: TourServiceProtocol
    private var journeys: [Journey] = []
    private var selectDay: Journey?
    
    init(presenter: ItineraryPresenterProtocol, tourId: String, tourService: TourServiceProtocol) {
        self.presenter = presenter
        self.tourId = tourId
        self.tourService = tourService
    }
}

extension ItineraryInteractor: ItineraryInteractorProtocol {
    
    func viewDidLoad() {
        tourService.getItineraryTour(tourId: tourId) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    self.journeys = list
                    guard let firstJourney = list.first else { return }
                    self.presenter.presentItineraryTourDay(list, selectedDay: firstJourney)
                case .failure:
                    break
                }
            }
        }
    }
    
    func didSelectDay(at index: Int) {
        let selectedDay = journeys[index]
        presenter.presentItineraryTourDay(journeys, selectedDay: selectedDay)
    }
    
    func didTapAddButton() {
        coordinator?.itineraryInteractorDidTapAddButton()
    }
}
