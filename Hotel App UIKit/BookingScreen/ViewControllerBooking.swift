//
//  ViewControllerReservation.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 31.12.2023.
//

import UIKit

final class ViewControllerBooking: UIViewController, IBookingView {
    var viewModel: IBookingViewModel
    let bookingView = BookingView()
    lazy  var scrollView = UIScrollView.customScroll(viewMain: self.view, viewContent: self.bookingView)
    
    private var state: State = .plain {
        didSet {
            switch state  {
            case .failure: bookingView.failureScreeen()
            case .loading: bookingView.loadingScreeen()
            case .loaded:  bookingView.loadedScreeen()
            default:  bookingView.loadingScreeen()
            }
        }
    }
    
    init(viewModel: IBookingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .loading
        
        view.backgroundColor = .white
        title = Constants.ControllerTitle.booking
        view.addSubview(scrollView)
        
        bookingView.delegate = self
        viewModel.requestt(urlString: Constants.Url.bookingURL)
        
        viewModel.result = {  [weak self] response in
            self?.state = .loaded
            DispatchQueue.main.async {
                self?.viewModel.updateInterfece(response: response)
                self?.bookingView.getHeaderData(response: response)
                self?.bookingView.tableViewPrice.reloadData()
                self?.bookingView.tableViewMainData.reloadData()
            }
        }
        
        viewModel.error = {
            self.state = .failure
        }
        
        addButtomForword()
    }
    
    @objc func buttonTapped(sender: UIButton) {
        viewModel.buttonTapped(sender: sender)
        self.bookingView.tableViewPassengers.reloadData()
    }
    
    private func addButtomForword() {
        let buttonForword = UIBarButtonItem(customView: self.bookingView.buttomForword)
        toolbarItems = [buttonForword]
        navigationController?.isToolbarHidden = false
    }
    
    func presentAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    func getPriceDataCount() -> Int {
        viewModel.getPriceDataCount
    }
    
    func getPassengersCount() -> Int {
        viewModel.getPassengersCount
    }
    
    func getMainDataCount() -> Int {
        viewModel.getMainDataCount
    }
    
    func isPassengerExpanded(section: Int) -> Bool {
        viewModel.isPassengerExpanded(section: section)
    }
    
    func getPassengerSectionData(section: Int) -> String {
        viewModel.getPassengerSectionData(section: section)
    }
    
    func getPriceData(indexPath: IndexPath) -> MainDataModel {
        viewModel.getPriceData(indexPath: indexPath)
    }
    
    func getPassengersData(indexPath: IndexPath) -> PassenderModel {
        viewModel.getPassengersData(indexPath: indexPath)
    }
    
    func getMainData(indexPath: IndexPath) -> MainDataModel {
        viewModel.getMainData(indexPath: indexPath)
    }
    
    func pushToAnotherController() {
        navigationController?.pushViewController(ViewControllerAccept(), animated: true)
    }
    
}



