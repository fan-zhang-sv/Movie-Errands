//
//  CastSwiftUIView.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/19/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import SwiftUI
import URLImage

struct Cast: View {
    
    let id: Int?
    
    let isPad = (UIDevice.current.userInterfaceIdiom == .pad)
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State private var casts: [CastModel] = []
    
    
    func updateMovies(from casts: [CastModel]) {
        self.casts = casts
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(width: 10, height: 0)
                .onAppear {
                    if let safeId = self.id {
                        let movieManager = MovieManager()
                        movieManager.getCasts(for: safeId, call: self.updateMovies)
                    }
                }
            if casts.count != 0 {
                HStack {
                    Text("Cast")
                        .font(Font.system(size:22, design: .default))
                        .fontWeight(.bold)
                    Spacer()
                }
                .frame(width: isPad ? 600 : screenWidth * 0.92)
                .offset(x: 2, y: 0)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                        ForEach(casts, id: \.cast_id) { cast in
                            EachCast(cast : cast)
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


struct EachCast: View {
    
    let cast: CastModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Circle()
                    .fill(Color(UIColor.secondarySystemBackground))
                    .frame(width: 110, height: 110)
                if cast.cast_id != nil {
                    if MovieManager.getImageURL(from: self.cast.profile_path ?? "") != MovieManager.imdbURL {
                        URLImage(URL(string: MovieManager.getImageURL(from: self.cast.profile_path ?? ""))!) { proxy in
                            proxy.image
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                        }
                    } else {
                        Image(systemName: "person")
                    }
                }
            }
            .frame(width: 110, height: 110)
            .cornerRadius(5)
            .shadow(radius: 4)
            .padding(.trailing, 7)
            Text(cast.name ?? "")
                .font(.body)
                .lineLimit(3)
                .frame(width: 110, alignment: .center)
                .multilineTextAlignment(.center)
                .padding(.top, 2)
                .padding(.bottom, 4)
            Text(cast.character ?? "")
                .font(.caption)
                .foregroundColor(Color(UIColor.systemGray))
                .frame(width: 110, alignment: .center)
                .multilineTextAlignment(.center)
        }
        .padding(.trailing, 4)
    }
}
