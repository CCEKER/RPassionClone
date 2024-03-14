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
		
		let journeyDaysViewModel: [JourneyDayViewModel] = journeys.map { journey in
			JourneyDayViewModel(id: journey.id, title: "Day \(journey.day)", isSelected: journey.day == selectedDay.day)
		}
        
		let selectedJourneyViewModel = JourneyViewModel(
			title: "Start Point \(selectedDay.day)",
			subtitle: "Select the location where the tour will start",
			buttonTitle: "Continue",
			navigationTitle: "Itinerary",
			endPointTitle: "End Point",
			endPointSubtitle: "Choose the location to meet at the end of the day",
			helperText: "*You will be able to add stops after selecting the start and end points",
			skipButtonTitle: "Skip"
		)
		
		viewController?.displayViewState(.updated(collectionData: journeyDaysViewModel, selectedJourneyViewodel: selectedJourneyViewModel))
    }
}
