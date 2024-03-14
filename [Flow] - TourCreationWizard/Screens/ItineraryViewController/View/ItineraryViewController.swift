//
//  ItineraryViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 14.03.2024.
//

import UIKit

protocol ItineraryViewControllerProtocol: AnyObject {
    func displayViewModel(_ viewModel: [ItineraryViewModel])
}

class ItineraryViewController: UIViewController {
    
    private let customView = ItineraryView()
    private let interactor: ItineraryInteractorProtocol
    private var collectionData: [ItineraryViewModel] = []
    
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
        
        interactor.viewDidLoad()
    }
}

extension ItineraryViewController: ItineraryViewControllerProtocol {
    
    func displayViewModel(_ viewModel: [ItineraryViewModel]) {
        self.collectionData = viewModel
        customView.startPointTitle.text = viewModel.first?.title
        customView.startPointSubtitle.text = viewModel.first?.subtitle
        customView.endPointLabel.text = viewModel.first?.endPointTitle
        customView.endPointSubtitleLabel.text = viewModel.first?.endPointSubtitle
        customView.helperText.text = viewModel.first?.helperText
        customView.itineraryContinueButton.setTitle(viewModel.first?.buttonTitle, for: .normal)
        customView.skipButton.setTitle(viewModel.first?.skipButtonTitle, for: .normal)
        self.title = viewModel.first?.navigationTitle
        customView.collectionView.reloadData()
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
