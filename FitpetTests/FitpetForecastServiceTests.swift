//
//  FitpetForecastServiceTests.swift
//  FitpetTests
//
//  Created by 박지성 on 2023/05/30.
//

import XCTest
@testable import Fitpet
import RxSwift

final class FitpetForecastServiceTests: XCTestCase {
    
    var sut: ForecastService!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = ForecastService()
        self.disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        self.sut = nil
        self.disposeBag = nil
        try super.tearDownWithError()
    }
    
    func test_requestDailyForecastOf() {
        // given
        let expectation = XCTestExpectation()
        let cityName = "seoul"
        let countryCode = "KR"
        let timeZone = TimeZone(abbreviation: "KST")!
        var model: DailyForecastModel?
        var error: Error?
        
        // when
        self.sut.requestDailyForecastOf(
            cityName: cityName,
            countryCode: countryCode,
            timeZone: timeZone)
        .subscribe(
            onSuccess: {
                model = $0
                expectation.fulfill()
            },
            onFailure: {
                error = $0
                expectation.fulfill()
            })
        .disposed(by: self.disposeBag)
        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertNil(error)
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.locationName.lowercased(), cityName.lowercased())
        XCTAssertEqual(model?.timeZone, timeZone)
        XCTAssertTrue(model?.forecasts.isEmpty == false)
        XCTAssertEqual(model?.forecasts.count, 5)
    }

}
