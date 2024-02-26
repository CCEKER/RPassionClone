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
			
			var userInfoArray: [String] = []
			let driverName = participant.driver.userInfo.components(separatedBy: " ")
			
			if !driverName.isEmpty {
				userInfoArray.append(driverName[0])
				if driverName.count > 1 {
					let lastName = driverName[driverName.count - 1]
					let firstDigitOfLastName = lastName[0..<1]
					userInfoArray.append("\(firstDigitOfLastName).")
				}
			}
			
			if participant.passengers.count == 1 {
				userInfoArray.append("with a person")
			} else if participant.passengers.count > 1 {
				userInfoArray.append("with \(participant.passengers.count) people")
			}

			return ParticipantsViewModel(
				nickname: participant.car.nickname,
				carLabel: participant.car.label,
				imageUrl: participant.car.images.first,
				userInfo: userInfoArray.joined(separator: " ")
			)
        }
        viewController?.displayViewState(.list(viewModels), totalParticipantStatus: totalParticipantStatus)
    }
}

extension String {
	subscript(_ range: CountableRange<Int>) -> String {
		let start = index(startIndex, offsetBy: max(0, range.lowerBound))
		let end = index(start, offsetBy: min(self.count - range.lowerBound,
											 range.upperBound - range.lowerBound))
		return String(self[start..<end])
	}

	subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
		let start = index(startIndex, offsetBy: max(0, range.lowerBound))
		 return String(self[start...])
	}
}
