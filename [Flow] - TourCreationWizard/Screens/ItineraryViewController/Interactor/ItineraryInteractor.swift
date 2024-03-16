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
    func itineraryInteractorDidTapAddButton(selectedDayId: String)
}

final class ItineraryInteractor {
    
    private let presenter: ItineraryPresenterProtocol
    weak var coordinator: ItineraryInteractorCoordinatorDelegate?
    private let tourId: String
    private let tourService: TourServiceProtocol
    private var journeys: [Journey] = []
    private var selectDay: Journey?
    private var selectedDayIndex: Int?
    
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
                    self.selectedDayIndex = 0
                    self.presenter.presentItineraryTourDay(list, selectedDay: firstJourney)
                case .failure:
                    break
                }
            }
        }
    }
    
    func didSelectDay(at index: Int) {
        self.selectedDayIndex = index
        let selectedDay = journeys[index]
        presenter.presentItineraryTourDay(journeys, selectedDay: selectedDay)
    }
    
    func didTapAddButton() {
        guard let index = selectedDayIndex else { return }
        let selectedDayId = journeys[index].id
        coordinator?.itineraryInteractorDidTapAddButton(selectedDayId: selectedDayId)
    }
}
