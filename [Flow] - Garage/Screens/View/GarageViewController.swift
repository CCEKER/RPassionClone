//
//  GarageViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import UIKit

protocol GarageViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: GarageViewState)
}

class GarageViewController: UIViewController {
    
    private let customView = GarageView()
    private let interactor: GarageInteractorProtocol
    private var tableData: [CarTableViewCellModel] = []
    
    init(interactor: GarageInteractorProtocol) {
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
        
        setupTableView()
        configureNavigationBar()
        
        customView.addCarButton.addTarget(self, action: #selector(didTapEmptyAddCarButton), for: .touchUpInside)
        
        interactor.viewDidLoad()
    }
   
    @objc private func didTapEmptyAddCarButton() {
        interactor.didTapAddCarButton()
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .background
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
       
        self.title = "My Garage"
        
        let addCarButton = UIBarButtonItem(title: "+ Add Car", style: .plain, target: self, action: #selector(didTapAddCarButton))
        navigationItem.rightBarButtonItem = addCarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc private func didTapAddCarButton() {
        interactor.didTapAddCarButton()
    }
    
    private func setupTableView() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    func addCarToList(newCar: Car) {
        interactor.addNewCarToList(newCar)
    }
}

extension GarageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyGarageTableViewCell
        let carViewModel = tableData[indexPath.row]
        cell.reloadWith(viewModel: carViewModel)
        return cell
    }
}

extension GarageViewController: GarageViewControllerProtocol {
    
    func displayViewState(_ viewState: GarageViewState) {
        switch viewState {
            
        case .list(let carList):
            customView.tableView.isHidden = false
            customView.displayEmptyView(show: false)
            self.tableData = carList
            customView.tableView.reloadData()
            
        case .loading:
            customView.tableView.isHidden = true
            
        case .empty:
            customView.displayEmptyView(show: true)
            
        case .error(let errorViewModel):
            let alert = UIAlertController(title: errorViewModel.title, message: errorViewModel.description, preferredStyle: .alert)
            alert.addAction(.init(title: errorViewModel.cancelButtonTitle, style: .cancel))
            if let actionButtonTitle = errorViewModel.actionButtonTitle {
                alert.addAction(.init(title: actionButtonTitle, style: .default, handler: { _ in
                    print("error")
                }))
            }
            self.present(alert, animated: true)
        }
    }
}
