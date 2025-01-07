//
//  RecipeView.swift
//  RecipeViewer
//
//  Created by Mark Spano on 1/7/25.
//

import SwiftUI
//import AVKit
import WebKit

// Youtube requires that its movies be shown in web browsers instead of played directly in VideoPlayer

struct YouTubeView: UIViewRepresentable {
    let recipe: Recipe
    var videoId: String

    init(recipe: Recipe) {
        self.recipe = recipe
        //self.videoId = getVideoID(from: recipe.movieURL!)
        let code = recipe.movieURL?.absoluteString.components(separatedBy: "/").last
        let prunedCode = code?.dropFirst(8)
        self.videoId = String(prunedCode!)
    }
    
    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let demoURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: demoURL))
    }
}


@MainActor
struct CachingAsyncImage: View {
    
    // The view model holds the image cache
    @ObservedObject var recipeViewModel: RecipeViewModel
    
    @State var recipe: Recipe
    @State var image: Image?
    
    var url: URL?
    
    var body: some View {
        VStack {
            if let image {
                image
            } else {
                ProgressView()
                    .onAppear {
                        Task {
                            let renderer = ImageRenderer(content: Text("No image available").font(.footnote).fontWeight(.ultraLight))
                            let noImageAvailable = Image(uiImage: renderer.uiImage!)
                            
                            if let photoURL = recipe.smallPhotoURL {
                                image = await recipeViewModel.downloadImage(url: photoURL)
                                if let image {
                                    recipeViewModel.imageCache[photoURL] = image
                                } else {
                                    image = noImageAvailable
                                }
                            } else {
                                image = noImageAvailable
                            }
                        }
                    }
            }
        }
    }
}

struct RecipeListItem: View {
    @State var recipe: Recipe
    @State private var showMovie = false
    
    @ObservedObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                Text(recipe.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                Spacer()
                
                Text(recipe.cuisine + " cuisine")
                    .font(.title3)
                    .fontWeight(.light)
                    .padding(.bottom, 10)
            }
            .frame(maxHeight: 128)
            .padding(.leading, 10)
            
            Spacer()
            
            CachingAsyncImage(recipeViewModel: recipeViewModel, recipe: recipe)
                .frame(width: 128, height: 128)
                .clipShape(
                    RoundedRectangle(cornerRadius: 25)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.black, lineWidth: 2)
                )
        }
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        .background(Color(red: 0.95, green: 0.95, blue: 1.00))
        .clipShape(
            RoundedRectangle(cornerRadius: 25)
        )
        .onTapGesture {
            showMovie = true
        }
        .popover(isPresented: $showMovie) {
            YouTubeView(recipe: recipe)
                .frame(width: 300, height: 300)
                .padding()
        }
    }
}

struct RecipeView: View {
    
    @ObservedObject var recipeViewModel = RecipeViewModel()
    
    @State private var recipes = [Recipe]()
    
    var body: some View {
        Text("My Recipes")
            .fontWeight(.bold)
        
        switch recipeViewModel.recipes.count {
        case 0:
            Spacer()
            Text("No recipes found")
            Spacer()
            
        default:
            List {
                ForEach(recipeViewModel.recipes) { recipe in
                    RecipeListItem(recipe: recipe, recipeViewModel: recipeViewModel)
                }
            }
        }
    }
}

#Preview {
    RecipeView(recipeViewModel: RecipeViewModel())
}
