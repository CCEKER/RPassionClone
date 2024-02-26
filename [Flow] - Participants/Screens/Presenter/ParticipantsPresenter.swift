//
//  ParticipantsPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import Foundation

protocol ParticipantsPresenterProtocol {
    func presentParticipants(_ participants: [Participant], participantsLimit: Int, participantsJoined: Int)
}

final class ParticipantsPresenter: ParticipantsPresenterProtocol {
    
    weak var viewController: ParticipantsViewControllerProtocol?
    
    func presentParticipants(_ participants: [Participant], participantsLimit: Int, participantsJoined: Int) {
        let totalParticipantStatus = "\(participantsLimit) / \(participantsJoined)"
        let viewModels = participants.map { participant in
            return ParticipantsViewModel(id: participant.car.id, nickname: participant.car.nickname, carMakerModelTrimTitle: participant.car.label, maker: participant.car.maker.title, imageUrl: participant.car.maker.image ?? "", userInfo: participant.driver.userInfo, images: participant.car.images)
        }
        viewController?.displayViewState(.list(viewModels), totalParticipantStatus: totalParticipantStatus)
    }
}

