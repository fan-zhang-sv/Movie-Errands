//
//  HostingTableViewCell.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/11/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import SwiftUI
import URLImage

struct TabelCellSwiftUIView: View {
    var title: String
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    var imageURLString: String
    
    var body: some View {
        HStack {
            if idiom == .pad {
                Spacer()
                    .frame(width: 50)
            }
            
            if imageURLString != MovieManager.imageURL {
                URLImage(URL(string: imageURLString)!) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
                .frame(width: 120, height: 60)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 10))
            } else {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .fill(Color(UIColor.secondarySystemBackground))
                    .frame(width: 120, height: 60)
                    Image(systemName: "tv")
                }
                .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 10))
            }
            
            //            Image(uiImage: UIImage(named: "Avengers") ?? UIImage())
            //                .resizable()
            //                .aspectRatio(contentMode: .fill)
            //                .frame(width: 120, height: 60)
            //                .cornerRadius(5)
            //                .clipped()
            //                .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 10))
            Text(title)
            Spacer()
        }
//        .padding(.bottom, 15)
        .background(Color(UIColor.init(named: "backgroundColor")!))
    }
}

struct TabelCellSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TabelCellSwiftUIView(title: "Test", imageURLString: "https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg")
    }
}

