//
//  ForecasePresenter.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import Foundation

protocol ForecasePresentationLogic {
    func presentSomething(response: Forecase.Something.Response)
}

class ForecasePresenter: ForecasePresentationLogic {
    
    weak var viewController: ForecaseDisplayLogic?
    
    
    
    // MARK: Do something
    
    func presentSomething(response: Forecase.Something.Response) {
        let viewModel = Forecase.Something.ViewModel()
        self.viewController?.displaySomething(viewModel: viewModel)
    }
    
}
