//
//  ForecastViewController.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import UIKit
import RxSwift
import RxRelay

private typealias Strings = ForecastStrings

protocol ForecastDisplayLogic: AnyObject {
    func displayDailyForecasts(viewModel: Forecast.DailyForecasts.ViewModel)
    func displayDailyForecastsLoadingFailure()
    
    func displayNextDailyForecasts(viewModel: Forecast.DailyForecasts.ViewModel)
    func displayNextDailyForecastsLoadingFailure()
}

class ForecastViewController: UIViewController, ForecastDisplayLogic, LoadingIndicatorDisplayable, ToastDisplayable {
    
    var interactor: ForecastBusinessLogic?
    var router: (NSObjectProtocol & ForecastRoutingLogic & ForecastDataPassing)?
    
    private var rootView: ForecastView {
        if !self.isViewLoaded { self.loadViewIfNeeded() }
        return self.view as! ForecastView
    }
    private let disposeBag = DisposeBag()
    private let hasNextList = BehaviorRelay<Bool>(value: false)
    
    
    
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
        self.fipt.showLoadingIndicator(withDimmed: true)
        self.interactor?.requestDailyForecasts(request: .init())
    }
    
    func requestRefreshDailyForecasts() {
        self.interactor?.requestDailyForecasts(request: .init())
    }
    
    func displayDailyForecasts(viewModel: Forecast.DailyForecasts.ViewModel) {
        self.fipt.hideLoadingIndicator()
        self.hasNextList.accept(viewModel.hasNext)
        self.rootView.displayListModel(viewModel.listModel)
    }
    
    func displayDailyForecastsLoadingFailure() {
        self.fipt.hideLoadingIndicator()
        self.rootView.displayListLoadingFailure()
    }
    
    
    
    func requestNextDailyForecasts() {
        self.fipt.showLoadingIndicator(withDimmed: false)
        self.interactor?.requestNextDailyForecasts(request: .init())
    }
    
    func displayNextDailyForecasts(viewModel: Forecast.DailyForecasts.ViewModel) {
        self.fipt.hideLoadingIndicator()
        self.hasNextList.accept(viewModel.hasNext)
        self.rootView.displayNextListModel(viewModel.listModel)
    }
    
    func displayNextDailyForecastsLoadingFailure() {
        self.fipt.hideLoadingIndicator()
        self.fipt.showToast(withMessage: Strings.nextDailyForecastsLoadingFailureToastMessage)
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
        
        self.rootView.listRefreshTrigger
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                self?.requestRefreshDailyForecasts()
            }
            .disposed(by: self.disposeBag)
        
        self.rootView.nextListRequestTrigger
            .withLatestFrom(self.hasNextList)
            .filter { $0 }
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                self?.requestNextDailyForecasts()
            }
            .disposed(by: self.disposeBag)
    }
    
}
