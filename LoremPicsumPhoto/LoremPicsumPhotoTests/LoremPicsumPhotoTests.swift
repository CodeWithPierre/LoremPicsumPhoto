//
//  LoremPicsumPhotoTests.swift
//  LoremPicsumPhotoTests
//
//  Created by Pierre ILYAMUKURU on 11/30/25.
//

import XCTest
@testable import LoremPicsumPhoto

@MainActor
final class LoremPicsumPhotoViewModelTests: XCTestCase {
    
    // MARK: - Success Test
    func testloadLoremPicsumPhotosSuccess() async {
        let viewModel = LoremPicsumPhotoViewModel(service: MockCLoremPicsumPhotoServiceSuccess())
        await viewModel.loadLoremPicsumPhotos()
        
        XCTAssertEqual(viewModel.loremPicsumPhotos.count, 3)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // MARK: - Failure Test
    func testloadLoremPicsumPhotosFailure() async {
        let viewModel = LoremPicsumPhotoViewModel(service: MockCLoremPicsumPhotoServiceFailure())
        await viewModel.loadLoremPicsumPhotos()
        
        XCTAssertTrue(viewModel.loremPicsumPhotos.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, "The server returned an error. Status code: 500.")
    }
}
