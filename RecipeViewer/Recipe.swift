//
//  Recipe.swift
//  RecipeViewer
//
//  Created by Mark Spano on 1/7/25.
//

import SwiftUI

class Recipe: Decodable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case cuisine, name
        
        case id = "uuid"
        case largePhotoURL = "photo_url_large"
        case smallPhotoURL = "photo_url_small"
        case sourceURL = "source_url"
        case movieURL = "youtube_url"
    }
    
    let cuisine: String
    let name: String
    let id: UUID
    let largePhotoURL: URL?
    let smallPhotoURL: URL?
    let sourceURL: URL?
    let movieURL: URL?
}
