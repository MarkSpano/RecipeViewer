//
//  RecipeViewerTests.swift
//  RecipeViewerTests
//
//  Created by Mark Spano on 1/7/25.
//

import Testing
@testable import RecipeViewer

struct RecipeViewerTests {

    @Test func recipeFetch() async throws {
        let viewModel = RecipeViewModel()
        await viewModel.recipeDownloadTask(urlString: DownloadURLs.allRecipes)
        #expect(viewModel.recipes.count > 20)
    }
    
    @Test func recipeFetchEmpty() async throws {
        let viewModel = RecipeViewModel()
        await viewModel.recipeDownloadTask(urlString: DownloadURLs.empty)
        #expect(viewModel.recipes.count == 0)
    }
    
    @Test func recipeFetchMalformed() async throws {
        let viewModel = RecipeViewModel()
        await viewModel.recipeDownloadTask(urlString: DownloadURLs.malformed)
        #expect(viewModel.recipes.count == 0)
    }
    
}
