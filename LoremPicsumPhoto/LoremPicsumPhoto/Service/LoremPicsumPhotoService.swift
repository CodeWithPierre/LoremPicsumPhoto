//
//  LoremPicsumPhotoService.swift
//  LoremPicsumPhoto
//
//  Created by Pierre ILYAMUKURU on 11/30/25.
//
import Foundation

///Create a Service Protocol for dependency injection
protocol LoremPicsumPhotoServiceProtocol {
    func fetchLoremPicsumPhotos(_ page: Int,_ limit: Int) async throws -> [LoremPicsumPhoto]
}

/// Enum of service errors
enum LoremPicsumPhotoServiceError: LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int? = nil)
    case noData
    case decodingFailed(Error)
    case unknown(Error? = nil)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
            
        case .requestFailed(let statusCode):
            if let code = statusCode {
                return "The server returned an error. Status code: \(code)."
            } else {
                return "The network request failed."
            }
            
        case .noData:
            return "The server returned no data."
            
        case .decodingFailed(let underlyingError):
            return "Failed to decode the response: \(underlyingError.localizedDescription)"
            
        case .unknown(let underlyingError):
            if let error = underlyingError {
                return "An unknown error occurred: \(error.localizedDescription)"
            } else {
                return "An unknown error occurred."
            }
        }
    }
}

final class LoremPicsumPhotoService: LoremPicsumPhotoServiceProtocol {
    
    private let baseURL = "https://picsum.photos/v2/list"
    
    /// Fetches photos from the API using async/await.
    func fetchLoremPicsumPhotos(_ page: Int,_ limit: Int = 30) async throws -> [LoremPicsumPhoto] {
        
        let urlString = "\(baseURL)?page=\(page)&limit=\(limit)"
        guard let url = URL(string: urlString) else {
            throw LoremPicsumPhotoServiceError.invalidURL
        }
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw LoremPicsumPhotoServiceError.requestFailed()
        }
        
        if let http = response as? HTTPURLResponse,
           !(200...299).contains(http.statusCode) {
            throw LoremPicsumPhotoServiceError.requestFailed(statusCode: http.statusCode)
        }
        
        do {
            return try JSONDecoder().decode([LoremPicsumPhoto].self, from: data)
        } catch {
            throw LoremPicsumPhotoServiceError.decodingFailed(error)
        }
    }
}
