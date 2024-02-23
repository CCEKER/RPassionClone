//
//  TourDetailsViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import UIKit

protocol TourDetailsViewControllerProtocol: AnyObject {
    func displayTourDetail(_ viewModels: TourDetailsViewModel)
}

class TourDetailsViewController: UIViewController {
    
    private let customView = TourDetailsView()
    private let interactor: TourDetailsInteractorProtocol
    private var tourDetailViewModel: TourDetailsViewModel?
    private var allowedMakerViewModel: [AllowedMakerViewModel] = []
    
    init(interactor: TourDetailsInteractorProtocol) {
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
        
        configureNavigationBar()
        collectionData()
        
        customView.invisibleButton.addTarget(self, action: #selector(didTapParticipantsButton), for: .touchUpInside)
        
        interactor.viewDidLoad()
    }
    
    @objc private func didTapParticipantsButton() {
        interactor.didTapParticipants()
    }
    
    private func configureNavigationBar() {
        self.title = "Tour Detail"
    }
    
    private func collectionData() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
    }
}

extension TourDetailsViewController: TourDetailsViewControllerProtocol {
    
    func displayTourDetail(_ viewModels: TourDetailsViewModel) {
        customView.reloadWith(viewModels)
        self.allowedMakerViewModel = viewModels.allowedMakers
        customView.collectionView.reloadData()
    }
}

extension TourDetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allowedMakerViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TourDetailCollectionViewCell
        let maker = allowedMakerViewModel[indexPath.row]
        cell.reloadWith(with: maker)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 100)
    }
}
