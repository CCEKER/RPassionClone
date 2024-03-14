//
//  ItineraryPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 14.03.2024.
//

import Foundation

protocol ItineraryPresenterProtocol {
    func presentItineraryTourDay(_ journeys: [Journey], selectedDay: Journey)
}

final class ItineraryPresenter: ItineraryPresenterProtocol {
    
    weak var viewController: ItineraryViewControllerProtocol?
    
    func presentItineraryTourDay(_ journeys: [Journey], selectedDay: Journey) {
        
        let viewModel = journeys.map { journey -> ItineraryViewModel in
            return ItineraryViewModel(
                id: journey.id,
                day: journey.day,
                isSelected: journey.day == selectedDay.day,
                title: "Start Point",
                subtitle: "Select the location where the tour will start",
                buttonTitle: "Continue",
                navigationTitle: "Itinerary",
                endPointTitle: "End Point",
                endPointSubtitle: "Choose the location to meet at the end of the day",
                helperText: "*You will be able to add stops after selecting the start and end points",
                skipButtonTitle: "Skip"
            )
        }
        viewController?.displayViewModel(viewModel)
    }
}
