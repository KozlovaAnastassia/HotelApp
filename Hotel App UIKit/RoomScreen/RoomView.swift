//
//  RoomView.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 31.12.2023.
//

import UIKit

private extension CGFloat {
    static let tableViewHeghtRow = 550.0
}

protocol IRoomView: AnyObject {
    func getRoomsCount() -> Int
    func getRoomData(indexPath: IndexPath) -> Room
    func goForward(vc: UIViewController)
}

final class RoomView: UIView {
    
    weak var delegate: IRoomView?
    private lazy var labelError = UILabel.labelError()
    private lazy var activityIndicator = UIActivityIndicatorView.activityIndicator()
    lazy var tableViewRoom = UITableView.customTableView(cellClass: RoomCell.self, reuseIdentifier: RoomCell.identifier)
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubViews()
        setConstraints()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    private func addSubViews() {
        addSubview(tableViewRoom)
        addSubview(labelError)
        addSubview(activityIndicator)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([            
            tableViewRoom.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableViewRoom.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableViewRoom.topAnchor.constraint(equalTo: topAnchor),
            tableViewRoom.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            labelError.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelError.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setDelegates() {
        tableViewRoom.delegate = self
        tableViewRoom.dataSource = self
    }

    
    func failureScreeen() {
        tableViewRoom.isHidden = true
        labelError.isHidden = false
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func loadingScreeen() {
        tableViewRoom.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        labelError.isHidden = true
    }
    
    func loadedScreeen() {
        tableViewRoom.isHidden = false
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        labelError.isHidden = true
    }
}

extension RoomView: UITableViewDelegate, UITableViewDataSource  {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         delegate?.getRoomsCount() ?? Int()
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  CGFloat.tableViewHeghtRow
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomCell.identifier, for: indexPath) as? RoomCell

         if let model = delegate?.getRoomData(indexPath: indexPath) {
             cell?.configure(model)
         }
        cell?.buttonAction = {
            let vc = ViewControllerBooking(viewModel: BookingViewModel(networkService: NetworkService()))
            self.delegate?.goForward(vc: vc)
            }
        return cell ?? UITableViewCell()
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
