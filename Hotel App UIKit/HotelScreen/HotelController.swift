//
//  ViewController.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

final class HotelViewController: UIViewController, IHotelView {
 
    private var viewModel: IHotelViewModel
    let hotelView = HotelView()
    lazy var scrollView = UIScrollView.customScroll(viewMain: self.view, viewContent: hotelView)
    
    private var state: State = .plain {
        didSet {
            switch state  {
            case .failure: hotelView.failureScreeen()
            case .loading: hotelView.loadingScreeen()
            case .loaded:  hotelView.loadedScreeen()
            default:  hotelView.loadingScreeen()
            }
        }
    }
    
    init(viewModel: IHotelViewModel) {
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
        title = Constants.ControllerTitle.hotel
        view.addSubview(scrollView)
        
        hotelView.delegate = self
        viewModel.requestt(urlString: Constants.Url.hotelURL)
        
        viewModel.result = {  [weak self] response in
            self?.state = .loaded
            DispatchQueue.main.async {
                self?.hotelView.updateInterfece(response: response)
            }
        }
        viewModel.error = {
            self.state = .failure
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addButtomForword()
    }
    
    func addButtomForword() {
        let buttonForword = UIBarButtonItem(customView: self.hotelView.buttomForword)
        toolbarItems = [buttonForword]
        navigationController?.isToolbarHidden = false
    }
    
    func getPeculiaritiesCount() -> Int {
        viewModel.getPeculiaritiesCount()
    }
    
    func getImagesCount() -> Int {
        viewModel.getImagesCount()
    }
    
    func getPeculiarities(indexPath: IndexPath) -> String {
        viewModel.getPeculiarities(indexPath: indexPath)
    }
    
    func getImage(indexPath: IndexPath) -> ImageModel {
        viewModel.getImage(indexPath: indexPath)
    }
    
    func pushToAnotherController(text: String) {
        navigationController?.pushViewController(ViewControllerRoom(titleHotel: text,
                                                                    viewModel: RoomViewModel(networkService: NetworkService())),
                                                 animated: true)
    }
}









