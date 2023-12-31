//
//  ViewControllerRoom.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 30.12.2023.
//

import UIKit

final class ViewControllerRoom: UIViewController, IRoomView {

    private var viewModel: IRoomViewModel
    private let titleHotel: String
    private let roomView = RoomView()
    
    private lazy var scrollView = UIScrollView.customScroll(viewMain: self.view, viewContent: roomView)
    
    private var state: State = .plain {
        didSet {
            switch state  {
            case .failure: roomView.failureScreeen()
            case .loading: roomView.loadingScreeen()
            case .loaded:  roomView.loadedScreeen()
            default:  roomView.loadingScreeen()
            }
        }
    }
    
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
        title = titleHotel
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        state = .loading
        roomView.delegate = self
        
        viewModel.requestt(urlString: Constants.Url.roomURL)
        
        viewModel.result = {  [weak self]  in
            self?.state = .loaded
            DispatchQueue.main.async {
                self?.roomView.tableViewRoom.reloadData()
            }
        }
        viewModel.error = {
            self.state = .failure
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
    }
    
    func getRoomsCount() -> Int {
        viewModel.getRoomsCount
    }
    
    func getRoomData(indexPath: IndexPath) -> Room {
        viewModel.getRoomData(indexPath: indexPath)
    }
    
    func goForward(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



