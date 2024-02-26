//
//  ParticipantsViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import UIKit

protocol ParticipantsViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: ParticipantsViewState, totalParticipantStatus: String)
}

class ParticipantsViewController: UIViewController {
    
    private let customView = ParticipantsView()
    private let interactor: ParticipantsInteractorProtocol
    private var tableData: [ParticipantsViewModel] = []
    
    init(interactor: ParticipantsInteractorProtocol) {
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
        setupTableView()
        
        interactor.viewDidLoad()
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.title = "Participants"
    }
    
    private func setupTableView() {
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
    }
}

extension ParticipantsViewController: ParticipantsViewControllerProtocol {
    
    func displayViewState(_ viewState: ParticipantsViewState, totalParticipantStatus: String) {
        
        switch viewState {
        case .list(let participants):
            self.tableData = participants
            customView.reloadWith(totalParticipantStatus: totalParticipantStatus)
            customView.tableView.reloadData()
        case .loading:
            customView.tableView.isHidden = true
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

extension ParticipantsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ParticipantTableViewCell
        let participants = tableData[indexPath.row]
        cell.reloadWith(participants)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didTapParticipants(indexPath.row)
    }
}
