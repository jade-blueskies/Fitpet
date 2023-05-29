//
//  ForecastViewController.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import UIKit

protocol ForecastDisplayLogic: AnyObject {
    func displayDailyForecasts(viewModel: Forecast.DailyForecasts.ViewModel)
}

class ForecastViewController: UIViewController, ForecastDisplayLogic {
    
    var interactor: ForecastBusinessLogic?
    var router: (NSObjectProtocol & ForecastRoutingLogic & ForecastDataPassing)?
    
    private var rootView: ForecastView {
        if !self.isViewLoaded { self.loadViewIfNeeded() }
        return self.view as! ForecastView
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
        let interactor = ForecastInteractor()
        let presenter = ForecastPresenter()
        let router = ForecastRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    
    // MARK: View lifecycle
    
    override func loadView() {
        self.view = ForecastView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestDailyForecasts()
    }
    
    
    
    // MARK: Use case - DailyForecasts
    
    func requestDailyForecasts() {
        self.interactor?.requestDailyForecasts(request: .init())
    }
    
    func displayDailyForecasts(viewModel: Forecast.DailyForecasts.ViewModel) {
        print(viewModel.listModel)
    }
    
}
