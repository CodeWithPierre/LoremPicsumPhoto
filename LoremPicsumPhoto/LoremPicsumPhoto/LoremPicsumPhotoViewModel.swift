//
//  LoremPicsumPhotoViewModel.swift
//  LoremPicsumPhoto
//
//  Created by Pierre ILYAMUKURU on 11/30/25.
//

import Foundation

@MainActor
final class LoremPicsumPhotoViewModel: ObservableObject {
    
    @Published var loremPicsumPhotos: [LoremPicsumPhoto] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let service: LoremPicsumPhotoServiceProtocol
    
    init(service: LoremPicsumPhotoServiceProtocol = LoremPicsumPhotoService()) {
        self.service = service
    }
    
    func loadLoremPicsumPhotos() async {
        isLoading = true
        errorMessage = nil
        
        do {
            loremPicsumPhotos = try await service.fetchLoremPicsumPhotos()
        } catch let error as LoremPicsumPhotoServiceError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = LoremPicsumPhotoServiceError.unknown(error).localizedDescription
        }
        isLoading = false
    }
}
