//
//  ViewControllerRoom.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 30.12.2023.
//

import UIKit

private extension CGFloat {
    static let tableViewHeghtRow = 550.0
}

final class ViewControllerRoom: UITableViewController {
    
    private var viewModel: IRoomViewModel
    let titleHotel: String
    
    init(titleHotel: String, viewModel: IRoomViewModel) {
        self.titleHotel = titleHotel
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = titleHotel
        
        viewModel.requestt(urlString: Constants.Url.roomURL)
        
        viewModel.result = {  [weak self]  in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        tableView.register(RoomCell.self, forCellReuseIdentifier: RoomCell.identifier)
        navigationController?.isToolbarHidden = true
    }
}

extension ViewControllerRoom {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getRoomsCount
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  CGFloat.tableViewHeghtRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomCell.identifier, for: indexPath) as? RoomCell

        let model = viewModel.getRoomData(indexPath: indexPath)
        cell?.configure(model)
        
        cell?.buttonAction = {
            let vc = ViewControllerBooking(viewModel: BookingViewModel(networkService: NetworkService()))
                self.navigationController?.pushViewController(vc, animated: true)
            }
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


