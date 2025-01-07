//
//  RecipeViewModel.swift
//  RecipeViewer
//
//  Created by Mark Spano on 1/7/25.
//

import SwiftUI

enum DownloadURLs: String {
    case allRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    case malformed = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    case empty = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
}

class RecipeViewModel: ObservableObject {
    var imageCache = [URL: Image]()
    @Published var recipes = [Recipe]()
    
    init() {
        Task {
            await recipeDownloadTask()
        }
    }
    
    @MainActor
    func recipeDownloadTask(urlString: DownloadURLs = DownloadURLs.allRecipes) async {
        guard let url = URL(string: urlString.rawValue) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let recipeDict = try JSONDecoder().decode([String: [Recipe]].self, from: data)
            if let recipes = recipeDict["recipes"]{
                self.recipes = recipes
            }
        } catch {
            recipes = [Recipe]()
            print("recipe fetch failed: \(error)")
        }
    }
    
    @MainActor
    func downloadImage(url: URL?) async -> Image? {
        do {
            guard let url else { return nil }
            
            // Check if the image is cached already
            if let cachedImage = imageCache[url] {
                return cachedImage
            } else {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                guard let uiImage = UIImage(data: data) else {
                    return nil
                }
                let newImage = Image(uiImage: uiImage)
                imageCache[url] = newImage
                return newImage
            }
        } catch {
            print("Error downloading: \(error)")
            return nil
        }
    }

}
