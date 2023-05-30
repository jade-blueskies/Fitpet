//
//  FitpetOpenWeatherMapAPITests.swift
//  FitpetTests
//
//  Created by 박지성 on 2023/05/30.
//

import XCTest
@testable import Fitpet
import RxSwift

final class FitpetOpenWeatherMapAPITests: XCTestCase {
    
    var sut: OpenWeatherMapAPI!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = OpenWeatherMapAPI()
        self.disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.disposeBag = nil
        try super.tearDownWithError()
    }
    
    func test_apiKey() {
        XCTAssertNotNil(OpenWeatherMapAPI.apiKey)
    }
    
    func test_requestCoordinatesBy() {
        // given
        let expectation = XCTestExpectation()
        let cityName = "seoul"
        let countryCode = "KR"
        var dtos: [OWMCoordinatesDto]?
        var error: Error?
        
        // when
        self.sut.requestCoordinatesBy(cityName: cityName, countryCode: countryCode, limit: 1)
            .subscribe(
                onSuccess: {
                    dtos = $0
                    expectation.fulfill()
                },
                onFailure: {
                    error = $0
                    expectation.fulfill()
                })
            .disposed(by: self.disposeBag)
        wait(for: [expectation], timeout: 2.0)
        
        // then
        XCTAssertNil(error)
        XCTAssertNotNil(dtos)
        XCTAssertTrue(dtos?.isEmpty == false)
    }
    
    func test_requestOneCall() {
        // given
        let expectation = XCTestExpectation()
        let lat = 37.5667
        let lon = 126.9783
        let units = "metric"
        var dto: OWMOneCallDto?
        var error: Error?
        
        // when
        self.sut.requestOneCall(lat: lat, lon: lon, units: units)
            .subscribe(
                onSuccess: {
                    dto = $0
                    expectation.fulfill()
                },
                onFailure: {
                    error = $0
                    expectation.fulfill()
                })
            .disposed(by: self.disposeBag)
        wait(for: [expectation], timeout: 2.0)
        
        // then
        XCTAssertNil(error)
        XCTAssertNotNil(dto)
        XCTAssertEqual(dto?.lat, lat)
        XCTAssertEqual(dto?.lon, lon)
        XCTAssertTrue(dto?.daily.isEmpty == false)
    }
    
}
