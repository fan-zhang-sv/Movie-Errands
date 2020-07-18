//
//  InformationSwiftUIView.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/19/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import SwiftUI
import URLImage

struct Background: View {
    
    let bgURL: String
    
    let isPad = (UIDevice.current.userInterfaceIdiom == .pad)
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack {
            if bgURL != MovieManager.bgURL {
                URLImage(URL(string: bgURL)!) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
                .frame(width: isPad ? 768 : screenWidth)
        }
        .frame(width: isPad ? 768 : screenWidth, height: isPad ? 800 : screenHeight * 0.75)
        .clipped()
    }
}


struct Poster: View {
    
    let posterURL: String
    
    let isPad = (UIDevice.current.userInterfaceIdiom == .pad)
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        URLImage(URL(string: posterURL)!) { proxy in
            proxy.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
        }
        .frame(width: isPad ? 200 : screenWidth * 0.4)
        .overlay(
            Rectangle().stroke(Color.white, lineWidth: 5)
        )
            .clipped()
            .shadow(radius: 10)
    }
}

struct BigInfo: View {
    
    let posterURL: String
    let imdbURL: String
    let title: String
    let overview: String
    let isAdded: () -> Bool
    let deletefromCoreData: () -> Void
    let writeToCoreData: () -> Void
    @State var added: Bool = false
    
    let isPad = (UIDevice.current.userInterfaceIdiom == .pad)
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        VStack {
            if posterURL != MovieManager.imageURL {
                Poster(posterURL: posterURL)
            }
            Text(title)
                .font(Font.system(size:26, design: .default))
                .foregroundColor(.white)
                .fontWeight(.black)
                .frame(width: isPad ? 614 :screenWidth * 0.8)
                .multilineTextAlignment(.center)
                .padding(.top)
                .onAppear{
                    self.added = self.isAdded()
                }
            HStack {
                Button(action: {
                    let alreadyIn = self.isAdded()
                    if alreadyIn {
                        self.deletefromCoreData()
                    } else {
                        self.writeToCoreData()
                    }
                    self.added = !alreadyIn
                }) {
                    Text(added ? "Remove" : "Favorite")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(width: isPad ? 350 :screenWidth * 0.6)
                }.buttonStyle(NeumorphicButtonStyle(bgColor: added ? Color.green : Color.blue))
                Button(action: {
                    if self.imdbURL != MovieManager.imdbURL {
                        if let url = URL(string: self.imdbURL) {
                            UIApplication.shared.open(url)
                        }
                    }
                }) {
                    Text("IMDb")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .frame(width: 50)
                }.buttonStyle(NeumorphicButtonStyle(bgColor: Color.yellow))
            }
            .padding()
            Text(overview)
                .font(Font.system(size:14, design: .default))
                .foregroundColor(.white)
                .fontWeight(.light)
                .lineLimit(3)
                .truncationMode(.tail)
                .multilineTextAlignment(.leading)
                .padding(.top, 5)
                .padding(.bottom, 20)
                .frame(width: isPad ? 600 :screenWidth * 0.92)
        }
    }
}

struct Overview: View {
    
    let isPad = (UIDevice.current.userInterfaceIdiom == .pad)
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    let release: String
    let vote: Double
    let runtime: Int
    let status: String
    let adult: Bool?
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Overview")
                    .font(Font.system(size:22, design: .default))
                    .fontWeight(.bold)
                Spacer()
            }
            .frame(width: isPad ? 600 : screenWidth * 0.92)
            .offset(x: 2, y: 7)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if release != "" {
                        Element(prompt: "Release", value: release)
                    }
                    if vote != 0.0 {
                        Element(prompt: "Vote", value: String(vote))
                    }
                    if runtime != 0 {
                        Element(prompt: "Runtime", value: String(runtime)+"min")
                    }
                    if status != "" {
                        Element(prompt: "Status", value: status)
                    }
                    if adult != nil {
                        Element(prompt: "Adult", value: adult! ? "Yes" : "No")
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

struct Element: View {
    var prompt: String
    var value: String
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.systemBackground))
                //                .foregroundColor(colorScheme == .dark ? Color(UIColor.systemBackground) : .white)
                .frame(width: 90, height: 70)
//                .shadow(radius: colorScheme == .dark ? 0 : 4)
            VStack {
                Text(prompt)
                    .font(.headline)
                Text(value)
                    .font(.caption)
                    .foregroundColor(Color(UIColor.systemGray))
                    .padding(.top, 5)
            }
        }
        .padding(.trailing, 10)
    }
}
