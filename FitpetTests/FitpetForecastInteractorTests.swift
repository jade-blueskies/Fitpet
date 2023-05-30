//
//  FitpetForecastInteractorTests.swift
//  FitpetTests
//
//  Created by 박지성 on 2023/05/30.
//

import XCTest
@testable import Fitpet

final class FitpetForecastInteractorTests: XCTestCase {
    
    private var sut: ForecastInteractor!
    private var presenter: MockForecastPresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = ForecastInteractor()
        self.presenter = MockForecastPresenter()
        self.sut.presenter = self.presenter
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.presenter = nil
        try super.tearDownWithError()
    }
    
    func test_requestDailyForecasts() {
        // given
        let expectation = XCTestExpectation()
        self.presenter.response = nil
        self.presenter.error = nil
        
        // when
        self.presenter.responseHandler = {
            expectation.fulfill()
        }
        self.sut.requestDailyForecasts(request: .init())
        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertNil(self.presenter.error)
        XCTAssertNotNil(self.presenter.response)
        XCTAssertTrue(self.presenter.response?.forecasts.isEmpty == false)
    }
    
    func test_requestNextDailyForecasts() {
        // given
        let expectation = XCTestExpectation()
        self.presenter.response = nil
        self.presenter.error = nil
        
        // when
        self.presenter.responseHandler = {
            expectation.fulfill()
        }
        self.sut.requestNextDailyForecasts(request: .init())
        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertNil(self.presenter.error)
        XCTAssertNotNil(self.presenter.response)
        XCTAssertTrue(self.presenter.response?.forecasts.isEmpty == false)
    }

}


private final class MockForecastPresenter: ForecastPresentationLogic {
    
    var responseHandler: (() -> Void)?
    
    var response: Forecast.DailyForecasts.Response?
    var error: Error?
    
    func presentDailyForecasts(response: Fitpet.Forecast.DailyForecasts.Response) {
        self.response = response
        self.responseHandler?()
    }
    
    func presentDailyForecastsLoadingFailure(error: Error) {
        self.error = error
        self.responseHandler?()
    }
    
    func presentNextDailyForecasts(response: Fitpet.Forecast.DailyForecasts.Response) {
        self.response = response
        self.responseHandler?()
    }
    
    func presentNextDailyForecastsLoadingFailure(error: Error) {
        self.error = error
        self.responseHandler?()
    }
    
}
