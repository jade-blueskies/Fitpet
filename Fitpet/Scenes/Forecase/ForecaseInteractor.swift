//
//  ForecaseInteractor.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import Foundation

protocol ForecaseBusinessLogic {
    func doSomething(request: Forecase.Something.Request)
}

protocol ForecaseDataStore {
}

class ForecaseInteractor: ForecaseBusinessLogic, ForecaseDataStore {
    
    var presenter: ForecasePresentationLogic?
    var worker: ForecaseWorker?
    
    
    
    // MARK: Do something
    
    func doSomething(request: Forecase.Something.Request) {
        let response = Forecase.Something.Response()
        self.presenter?.presentSomething(response: response)
    }
    
}
