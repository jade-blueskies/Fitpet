//
//  FitpetForecastPresenterTests.swift
//  FitpetTests
//
//  Created by 박지성 on 2023/05/30.
//

import XCTest
@testable import Fitpet

final class FitpetForecastPresenterTests: XCTestCase {
    
    private var sut: ForecastPresenter!
    private var viewController: MockForecastViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = ForecastPresenter()
        self.viewController = MockForecastViewController()
        self.sut.viewController = self.viewController
    }
    
    override func tearDownWithError() throws {
        self.sut = nil
        self.viewController = nil
        try super.tearDownWithError()
    }
    
    func test_presentDailyForecasts() {
        // given
        let expectation = XCTestExpectation()
        let forecasts: [DailyForecastModel] = [
            DailyForecastModel(
                locationName: "seoul",
                timeZone: TimeZone(abbreviation: "KST")!,
                forecasts: [
                    ForecastModel(
                        date: Date(),
                        weatherIconID: 500,
                        weatherDescription: "light rain",
                        minimumTemperature: 19,
                        maximumTemperature: 29)
                ])
        ]
        let hasNext: Bool = true
        var viewModel: Forecast.DailyForecasts.ViewModel?
        
        // when
        self.viewController.displayDailyForecastsHandler = {
            viewModel = $0
            expectation.fulfill()
        }
        self.sut.presentDailyForecasts(response: .init(
            forecasts: forecasts,
            hasNext: hasNext))
        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel?.listModel.isEmpty == false)
        XCTAssertEqual(viewModel?.listModel.first?.locationName, "SEOUL")
        XCTAssertTrue(viewModel?.listModel.first?.rows.isEmpty == false)
        XCTAssertEqual(viewModel?.listModel.first?.rows.first?.date, "Today")
        XCTAssertEqual(viewModel?.listModel.first?.rows.first?.weatherIconName, "wi-sprinkle")
    }
    
    func test_presentNextDailyForecasts() {
        // given
        let expectation = XCTestExpectation()
        let forecasts: [DailyForecastModel] = [
            DailyForecastModel(
                locationName: "seoul",
                timeZone: TimeZone(abbreviation: "KST")!,
                forecasts: [
                    ForecastModel(
                        date: Date(),
                        weatherIconID: 500,
                        weatherDescription: "light rain",
                        minimumTemperature: 19,
                        maximumTemperature: 29)
                ])
        ]
        let hasNext: Bool = true
        var viewModel: Forecast.DailyForecasts.ViewModel?
        
        // when
        self.viewController.displayNextDailyForecastsHandler = {
            viewModel = $0
            expectation.fulfill()
        }
        self.sut.presentNextDailyForecasts(response: .init(
            forecasts: forecasts,
            hasNext: hasNext))
        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel?.listModel.isEmpty == false)
        XCTAssertEqual(viewModel?.listModel.first?.locationName, "SEOUL")
        XCTAssertTrue(viewModel?.listModel.first?.rows.isEmpty == false)
        XCTAssertEqual(viewModel?.listModel.first?.rows.first?.date, "Today")
        XCTAssertEqual(viewModel?.listModel.first?.rows.first?.weatherIconName, "wi-sprinkle")
    }
    
    func test_presentDailyForecastsLoadingFailure() {
        // given
        let expectation = XCTestExpectation()
        
        // when
        self.viewController.displayDailyForecastsLoadingFailureHandler = {
            expectation.fulfill()
        }
        self.sut.presentDailyForecastsLoadingFailure(error: NSError())
        
        // then
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_presentNextDailyForecastsLoadingFailure() {
        // given
        let expectation = XCTestExpectation()
        
        // when
        self.viewController.displayNextDailyForecastsLoadingFailureHandler = {
            expectation.fulfill()
        }
        self.sut.presentNextDailyForecastsLoadingFailure(error: NSError())
        
        // then
        wait(for: [expectation], timeout: 5.0)
    }

}


private final class MockForecastViewController: ForecastDisplayLogic {
    
    var displayDailyForecastsHandler: ((Forecast.DailyForecasts.ViewModel) -> Void)?
    var displayDailyForecastsLoadingFailureHandler: (() -> Void)?
    
    var displayNextDailyForecastsHandler: ((Forecast.DailyForecasts.ViewModel) -> Void)?
    var displayNextDailyForecastsLoadingFailureHandler: (() -> Void)?
    
    func displayDailyForecasts(viewModel: Fitpet.Forecast.DailyForecasts.ViewModel) {
        self.displayDailyForecastsHandler?(viewModel)
    }
    
    func displayDailyForecastsLoadingFailure() {
        self.displayDailyForecastsLoadingFailureHandler?()
    }
    
    func displayNextDailyForecasts(viewModel: Fitpet.Forecast.DailyForecasts.ViewModel) {
        self.displayNextDailyForecastsHandler?(viewModel)
    }
    
    func displayNextDailyForecastsLoadingFailure() {
        self.displayNextDailyForecastsLoadingFailureHandler?()
    }
    
}
