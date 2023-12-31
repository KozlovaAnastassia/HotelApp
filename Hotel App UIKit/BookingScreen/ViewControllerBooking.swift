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
    lazy  var scrollView = UIScrollView.customScroll(view: self.view, stack: self.bookingView.stackViewMain)
    
    init(viewModel: IBookingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = Constants.ControllerTitle.booking
       
        bookingView.delegate = self
        viewModel.requestt(urlString: Constants.Url.bookingURL)
        
        viewModel.result = {  [weak self] response in
            DispatchQueue.main.async {
                self?.viewModel.updateInterfece(response: response)
                self?.bookingView.getHeaderData(response: response)
                self?.bookingView.tableViewPrice.reloadData()
                self?.bookingView.tableViewMainData.reloadData()
            }
        }
        
        addSubViews()
        let buttonBack = UIBarButtonItem(customView: self.bookingView.buttomForword)

        toolbarItems = [buttonBack]
        navigationController?.isToolbarHidden = false
    }
    
    private func addSubViews() {
        view.addSubview(scrollView)
    }


    @objc func buttonTapped(sender: UIButton) {
        viewModel.buttonTapped(sender: sender)
        self.bookingView.tableViewPassengers.reloadData()
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



