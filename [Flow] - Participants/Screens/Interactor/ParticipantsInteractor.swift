//
//  ParticipantsInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import Foundation

protocol ParticipantsInteractorProtocol {
    func viewDidLoad()
    func didTapParticipants(_ index: Int)
}

protocol ParticipantsInteractorCoordinatorDelegate: AnyObject {
	func participantsInteractorDidTapParticipant(driverId: String)
}

final class ParticipantsInteractor {
    
    weak var coordinator: ParticipantsInteractorCoordinatorDelegate?
    private let presenter: ParticipantsPresenterProtocol
    private let tourService: TourDetailServiceProtocol
    private var tourId: String
    private var participantsLimit: Int
    private var participantsJoined: Int
    private var participants: [Participant] = []
    
    init(presenter: ParticipantsPresenterProtocol, tourService: TourDetailServiceProtocol, tourId: String, participantsLimit: Int, participantsJoined: Int) {
        self.presenter = presenter
        self.tourService = tourService
        self.tourId = tourId
        self.participantsLimit = participantsLimit
        self.participantsJoined = participantsJoined
    }
}

extension ParticipantsInteractor: ParticipantsInteractorProtocol {
    
    func viewDidLoad() {
        tourService.getParticipants(tourId: tourId) { [weak self] result in
			guard let self else { return }
            switch result {
            case .success(let response):
                self.participants = response
                presenter.presentParticipants(response, participantsLimit: participantsLimit, participantsJoined: participantsJoined)
                
            case .failure(let error):
                print("Interactor Error: \(error)")
            }
        }
    }
    
    func didTapParticipants(_ index: Int) {
        let selectedParticipant = participants[index]
		coordinator?.participantsInteractorDidTapParticipant(driverId: selectedParticipant.driver.id)
    }
}
