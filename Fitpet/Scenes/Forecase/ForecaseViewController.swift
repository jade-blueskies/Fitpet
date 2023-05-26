//
//  ForecaseViewController.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import UIKit

protocol ForecaseDisplayLogic: AnyObject {
    func displaySomething(viewModel: Forecase.Something.ViewModel)
}

class ForecaseViewController: UIViewController, ForecaseDisplayLogic {
    
    var interactor: ForecaseBusinessLogic?
    var router: (NSObjectProtocol & ForecaseRoutingLogic & ForecaseDataPassing)?
    
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doSomething()
    }
    
    
    
    // MARK: Do something
    
    func doSomething() {
        let request = Forecase.Something.Request()
        self.interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Forecase.Something.ViewModel) {
        
    }
    
}
