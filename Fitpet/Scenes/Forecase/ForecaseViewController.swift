//
//  ForecaseViewController.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import UIKit

protocol ForecaseDisplayLogic: AnyObject {
    func displayDailyForecasts(viewModel: Forecase.DailyForecasts.ViewModel)
}

class ForecaseViewController: UIViewController, ForecaseDisplayLogic {
    
    var interactor: ForecaseBusinessLogic?
    var router: (NSObjectProtocol & ForecaseRoutingLogic & ForecaseDataPassing)?
    
    private var rootView: ForecaseView {
        if !self.isViewLoaded { self.loadViewIfNeeded() }
        return self.view as! ForecaseView
    }
    
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ForecaseInteractor()
        let presenter = ForecasePresenter()
        let router = ForecaseRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    
    // MARK: View lifecycle
    
    override func loadView() {
        self.view = ForecaseView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestDailyForecasts()
    }
    
    
    
    // MARK: Use case - DailyForecasts
    
    func requestDailyForecasts() {
        self.interactor?.requestDailyForecasts(request: .init())
    }
    
    func displayDailyForecasts(viewModel: Forecase.DailyForecasts.ViewModel) {
        print(viewModel.listModel)
    }
    
}
