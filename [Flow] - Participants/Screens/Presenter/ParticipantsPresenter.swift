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
        let userInfo = formatParticipantUserInfo(participants)
        let viewModels = participants.map { participant in
            return ParticipantsViewModel(id: participant.car.id, nickname: participant.car.nickname, carMakerModelTrimTitle: participant.car.label, maker: participant.car.maker.title, imageUrl: participant.car.maker.image ?? "", userInfo: userInfo, images: participant.car.images)
        }
        viewController?.displayViewState(.list(viewModels), totalParticipantStatus: totalParticipantStatus)
    }
    
    private func formatParticipantUserInfo(_ participants: [Participant]) -> String {
        
        switch participants.count {
        case 0:
            return ParticipantsInfo.none.description
        case 1:
            guard let name = participants.first?.driver.userInfo else {
                return "Invalid name"
            }
            return ParticipantsInfo.single(name: formatName(name)).description
        default:
            guard let name = participants.first?.driver.userInfo else {
                return "Invalid name"
            }
            return ParticipantsInfo.multipe(name: formatName(name), count: participants.count - 1).description
        }
    }
    
    private func formatName(_ name: String) -> String {
        let components = name.split { $0.isWhitespace }.map(String.init)
        guard let firstNameInitial = components.first, let lastNameInitial = components.last?.first else {
            return "Invalid name"
        }
        return "\(firstNameInitial) \(lastNameInitial.uppercased())."
    }
}

