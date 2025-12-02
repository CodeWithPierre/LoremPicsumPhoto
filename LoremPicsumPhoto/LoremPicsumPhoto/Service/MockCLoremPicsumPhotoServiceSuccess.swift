//
//  MockCLoremPicsumPhotoServiceSuccess.swift
//  LoremPicsumPhoto
//
//  Created by Pierre ILYAMUKURU on 12/1/25.
//

import SwiftUI
import Foundation

/// Mock service that returns 3 successful items.
final class MockCLoremPicsumPhotoServiceSuccess: LoremPicsumPhotoServiceProtocol {
    func fetchLoremPicsumPhotos(_ page: Int, _ limit: Int) async throws -> [LoremPicsumPhoto] {
        return [
            LoremPicsumPhoto(
                id: "0",
                author: "Alejandro Escamilla",
                width: 5000,
                height: 3333,
                url: "https://unsplash.com/photos/yC-Yzbqy7PY",
                downloadURL: "https://picsum.photos/id/0/5000/3333"
            ),
            LoremPicsumPhoto(
                id: "1",
                author: "Alejandro Escamilla",
                width: 5000,
                height: 3333,
                url: "https://unsplash.com/photos/LNRyGwIJr5c",
                downloadURL: "https://picsum.photos/id/1/5000/3333"
            ),
            LoremPicsumPhoto(
                id: "2",
                author: "Alejandro Escamilla",
                width: 5000,
                height: 3333,
                url: "https://unsplash.com/photos/N7XodRrbzS0",
                downloadURL: "https://picsum.photos/id/2/5000/3333"
            )
        ]
    }
}
