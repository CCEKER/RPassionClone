//
//  ItineraryViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 14.03.2024.
//

import UIKit

protocol ItineraryViewControllerProtocol: AnyObject {
	func displayViewState(_ viewState: ItineraryViewState)
}

class ItineraryViewController: UIViewController {
    
    private let customView = ItineraryView()
    private let interactor: ItineraryInteractorProtocol
    private var collectionData: [JourneyDayViewModel] = []
    
    init(interactor: ItineraryInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        
        customView.startPointAddButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        interactor.viewDidLoad()
    }
    
    @objc private func didTapAddButton() {
        interactor.didTapAddButton()
    }
}

extension ItineraryViewController: ItineraryViewControllerProtocol {
    	
	func displayViewState(_ viewState: ItineraryViewState) {
		switch viewState {
		case let .updated(collectionData, selectedJourneyViewodel):
			
			self.collectionData = collectionData
			customView.startPointTitle.text = selectedJourneyViewodel.title
			customView.startPointSubtitle.text = selectedJourneyViewodel.subtitle
			customView.endPointLabel.text = selectedJourneyViewodel.endPointTitle
			customView.endPointSubtitleLabel.text = selectedJourneyViewodel.endPointSubtitle
			customView.helperText.text = selectedJourneyViewodel.helperText
			customView.itineraryContinueButton.setTitle(selectedJourneyViewodel.buttonTitle, for: .normal)
			customView.skipButton.setTitle(selectedJourneyViewodel.skipButtonTitle, for: .normal)
			self.title = selectedJourneyViewodel.navigationTitle
			customView.collectionView.reloadData()
		}
	}
}

extension ItineraryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItineraryDayCollectionViewCell
        let journey = collectionData[indexPath.row]
        cell.reloadWith(journey, isSelectedDay: journey.isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.didSelectDay(at: indexPath.row)
    }
}
