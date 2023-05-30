//
//  ForecastViewController.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import UIKit
import RxSwift
import RxRelay

protocol ForecastDisplayLogic: AnyObject {
    func displayDailyForecasts(viewModel: Forecast.DailyForecasts.ViewModel)
    func displayDailyForecastsLoadingFailure(viewModel: Forecast.DailyForecasts.ViewModel)
}

class ForecastViewController: UIViewController, ForecastDisplayLogic {
    
    var interactor: ForecastBusinessLogic?
    var router: (NSObjectProtocol & ForecastRoutingLogic & ForecastDataPassing)?
    
    private var rootView: ForecastView {
        if !self.isViewLoaded { self.loadViewIfNeeded() }
        return self.view as! ForecastView
    }
    private let disposeBag = DisposeBag()
    
    
    
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
        self.bindWithInteractions()
        self.requestDailyForecasts()
    }
    
}



// MARK: - Use case DailyForecasts
extension ForecastViewController {
    
    func requestDailyForecasts() {
        self.interactor?.requestDailyForecasts(request: .init())
    }
    
    func displayDailyForecasts(viewModel: Forecast.DailyForecasts.ViewModel) {
        self.rootView.displayListModel(viewModel.listModel)
    }
    
    func displayDailyForecastsLoadingFailure(viewModel: Forecast.DailyForecasts.ViewModel) {
        self.rootView.displayListLoadingFailure()
    }
    
}



// MARK: - Intercations
extension ForecastViewController {
    
    private func bindWithInteractions() {
        self.rootView.listRequestTrigger
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                self?.requestDailyForecasts()
            }
            .disposed(by: self.disposeBag)
    }
    
}
