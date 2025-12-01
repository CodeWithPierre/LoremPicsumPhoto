//
//  MockCLoremPicsumPhotoServiceFailure.swift
//  LoremPicsumPhoto
//
//  Created by Pierre ILYAMUKURU on 12/1/25.
//

import SwiftUI
import Foundation

final class MockCLoremPicsumPhotoServiceFailure: LoremPicsumPhotoServiceProtocol {
    func fetchLoremPicsumPhotos() async throws -> [LoremPicsumPhoto] {
        throw LoremPicsumPhotoServiceError.requestFailed(statusCode: 500)
    }
}
