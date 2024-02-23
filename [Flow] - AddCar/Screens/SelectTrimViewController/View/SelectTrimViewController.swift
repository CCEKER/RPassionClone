//
//  SelectTrimViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import UIKit

protocol SelectTrimViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: SelectTrimViewState)
}

class SelectTrimViewController: UIViewController {
    
    private let customView = SelectTrimView()
    private let interactor: SelectTrimInteractorProtocol
    private var tableData: [TrimViewModel] = []
    
    init(interactor: SelectTrimInteractorProtocol) {
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
        interactor.viewDidLoad()
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "Select Trim"
    }
    
    private func setupTableView() {
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
    }
}

extension SelectTrimViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectTrimTableViewCell
        let trim = tableData[indexPath.row]
        cell.reloadWith(trim)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didTapMakerModelTrim(indexPath.row)
    }
}

extension SelectTrimViewController: SelectTrimViewControllerProtocol {
    
    func displayViewState(_ viewState: SelectTrimViewState) {
        switch viewState {
        
        case .list(let trimList):
            self.tableData = trimList
            self.customView.tableView.reloadData()
        
        case .loading:
            self.customView.tableView.isHidden = true
        
        case .error(let errorViewModel):
            let alert = UIAlertController(title: errorViewModel.title, message: errorViewModel.description, preferredStyle: .alert)
            alert.addAction(.init(title: errorViewModel.cancelButtonTitle, style: .cancel))
            if let actionButtonTitle = errorViewModel.actionButtonTitle {
                alert.addAction(.init(title: actionButtonTitle, style: .default, handler: { _ in
                    print("Error")
                }))
            }
            self.present(alert, animated: true)
        }
    }
}
