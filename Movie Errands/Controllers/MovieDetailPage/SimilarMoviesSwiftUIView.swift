//
//  SimilarMoviesSwiftUIView.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/19/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import SwiftUI
import URLImage

struct SimilarMovies: View {
    
    let id: Int?
    var update: (() -> Void)?
    
    let isPad = (UIDevice.current.userInterfaceIdiom == .pad)
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State private var simiMovies: [ResultModel] = []
    
    
    func updateMovies(from results: [ResultModel]) {
        self.simiMovies = results
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(width: 10, height: 0)
                .onAppear {
                    if let safeId = self.id {
                        let movieManager = MovieManager()
                        movieManager.getRelatedMovies(for: safeId, call: self.updateMovies)
                    }
                }
            if simiMovies.count != 0 {
                HStack {
                    Text("Similar Movies")
                        .font(Font.system(size:22, design: .default))
                        .fontWeight(.bold)
                    Spacer()
                }
                .frame(width: isPad ? 600 : screenWidth * 0.92)
                .offset(x: 2, y: 0)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(simiMovies, id: \.id) { result in
                            SimiMovie(result : result, update: self.update)
                        }
                    }
                    .padding(.bottom, 18)
                    .padding(.top, 7)
                    .padding(.leading, 7)
                    .padding(.trailing, isPad ? 84 + 84 : 25)
                    .offset(x: isPad ? 84 + 7 : 18, y: 0)
                }
                
                .frame(width: isPad ? 768 : screenWidth)
            }
        }
    }
}


struct SimiMovie: View {
    
    let result: ResultModel
    var update: (() -> Void)?
    
    @State private var movie: MovieModel?
    
    func updateMovie(for movie: MovieModel) {
        self.movie = movie
        print(movie)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            SimiMoviePoster(movie: $movie, update: update)
                .onAppear {
                    if let safeId = self.result.id {
                        let movieManager = MovieManager()
                        movieManager.open(for: safeId, call: self.updateMovie)
                    }
            }
            Text(result.title ?? "")
                .frame(width: 200, alignment: .leading)
                .lineLimit(1)
        }
        .padding(.trailing, 4)
    }
}


struct SimiMoviePoster: View {
    @Binding var movie: MovieModel?
    var update: (() -> Void)?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .circular)
                .fill(Color(UIColor.secondarySystemBackground))
            Image(systemName: "tv")
            if movie?.id != nil {
                NavigationLink(destination: Content(movie: movie!, update: update) ) {
                    if MovieManager.getImageURL(from: self.movie?.poster_path ?? "") != MovieManager.imdbURL {
                        URLImage(URL(string: MovieManager.getImageURL(from: self.movie?.poster_path ?? ""))!) { proxy in
                            proxy.image
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }
                    }
                }
            }
        }
        .frame(width: 200, height: 105)
        .cornerRadius(5)
        .shadow(radius: 4)
        .padding(.trailing, 7)
    }
}
