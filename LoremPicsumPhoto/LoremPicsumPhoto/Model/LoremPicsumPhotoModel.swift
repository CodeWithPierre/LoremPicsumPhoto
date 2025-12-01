//
//  LoremPicsumPhotoModel.swift
//  LoremPicsumPhoto
//
//  Created by Pierre ILYAMUKURU on 11/30/25.
//

struct LoremPicsumPhoto: Identifiable, Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadURL = "download_url"
    }
}
