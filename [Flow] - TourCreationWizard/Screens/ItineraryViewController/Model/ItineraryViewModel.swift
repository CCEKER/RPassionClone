//
//  ItineraryViewModel.swift
//  TourApp
//
//  Created by Cagatay Ceker on 14.03.2024.
//

import Foundation

struct ItineraryViewModel {
    let id: String
    let day: Int
    var isSelected: Bool
    let title: String
    let subtitle: String
    let buttonTitle: String
    let navigationTitle: String
    let endPointTitle: String
    let endPointSubtitle: String
    let helperText: String
    let skipButtonTitle: String
}

struct JourneyDayViewModel {
	let id: String
	let title: String
	var isSelected: Bool
}

struct JourneyViewModel {
	let title: String
	let subtitle: String
	let buttonTitle: String
	let navigationTitle: String
	let endPointTitle: String
	let endPointSubtitle: String
	let helperText: String
	let skipButtonTitle: String
}

enum ItineraryViewState {
	case updated(collectionData: [JourneyDayViewModel], selectedJourneyViewodel: JourneyViewModel)
}
