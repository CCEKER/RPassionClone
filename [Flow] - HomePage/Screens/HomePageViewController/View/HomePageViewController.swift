//
//  HomePageViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 5.01.2024.
//

import UIKit

protocol HomePageViewContollerProtocol: AnyObject {
    func displayView(viewModels: [HomePageViewModel])
}

class HomePageViewContoller: UIViewController {
    
    private let interactor: HomePageInteractorProtocol
    private let customView = HomePageView()
    private var homePageViewModels: [HomePageViewModel] = []
    
    override func loadView() {
        view = customView
    }
    
    init(interactor: HomePageInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        
        interactor.viewDidLoad()
    }
}

extension HomePageViewContoller: HomePageViewContollerProtocol {
    
    func displayView(viewModels: [HomePageViewModel]) {
        self.homePageViewModels = viewModels
        customView.tableView.reloadData()
    }
}

extension HomePageViewContoller: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homePageViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomePageTableViewCell
        let viewModels = homePageViewModels[indexPath.row]
        cell.reloadWith(viewModels)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didTapTourDetail(indexPath.row)
    }
}
