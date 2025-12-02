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
    @Published var page = 1
    let totalPhotoLimit = 90
    let photosPerPageLimit = 30
    
    private let service: LoremPicsumPhotoServiceProtocol
    
    init(service: LoremPicsumPhotoServiceProtocol = LoremPicsumPhotoService()) {
        self.service = service
    }
    
    func loadLoremPicsumFromStart() async {
        page = 1
        loremPicsumPhotos = []
        await loadLoremPicsumPage(page)
    }
    
    func loadNextLoremPicsumPage(photo: LoremPicsumPhoto) async {
        guard !isLoading else { return }
        
        if loremPicsumPhotos.count >= totalPhotoLimit {
            return
        }
        if photo.id == loremPicsumPhotos.last?.id {
            await loadLoremPicsumPage(page)
        }
    }
    
    private func loadLoremPicsumPage(_ page: Int) async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil
        
        do {
            let newPhotos = try await service.fetchLoremPicsumPhotos(page, photosPerPageLimit)
            if page == 1 {
                loremPicsumPhotos = newPhotos
            } else {
                loremPicsumPhotos.append(contentsOf: newPhotos)
            }
            
            self.page += 1
        } catch let error as LoremPicsumPhotoServiceError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = LoremPicsumPhotoServiceError.unknown(error).localizedDescription
        }
    }
}
