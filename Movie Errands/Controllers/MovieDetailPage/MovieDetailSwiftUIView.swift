//
//  MovieDetailSwiftUIView.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/17/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import UIKit
import SwiftUI
import URLImage
import CoreData

struct MovieDetailSwiftUIView: View {
    
    let movie: MovieModel
    var update: (() -> Void)?
    var dismiss: (() -> Void)?
    
    var btnBack : some View {
        Button(action:
            self.dismiss ?? {}
        ) {
            Image(systemName: "chevron.down")
                .font(.system(size: 24, weight: .semibold))
                .offset(x: -7)
        }
    }
    
    var body: some View {
        NavigationView {
            Content(movie: movie, update: update)
                .navigationBarTitle("")
                .navigationBarItems(leading: btnBack)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color(UIColor(named: "movieOrrange")!))
        .background(Color(UIColor.systemGray6))
        
    }
}


struct Content: View {
    
    let movie: MovieModel
    var update: (() -> Void)?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //    var storedMovie: StoredMovieModel?
    
    var body: some View {
        ScrollView {
            VStack {
                Background(bgURL: MovieManager.getBGURL(from: movie.backdrop_path ?? ""))
                    .overlay(
                        BigInfo(posterURL: MovieManager.getImageURL(from: movie.poster_path ?? ""),
                                imdbURL: MovieManager.getIMDbURL(from: movie.imdb_id ?? ""),
                                title: movie.title ?? "",
                                overview: movie.overview ?? "",
                                isAdded: isAdded,
                                deletefromCoreData: deletefromCoreData,
                                writeToCoreData: writeToCoreData
                        )
                        ,alignment: .bottom
                )
                Overview(release: movie.release_date ?? "",
                         vote: movie.vote_average ?? 0.0,
                         runtime: movie.runtime ?? 0,
                         status: movie.status ?? "",
                         adult: movie.adult)
                Cast(id: movie.id)
                SimilarMovies(id: movie.id, update: update)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}


struct MovieDetailSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieDetailSwiftUIView(movie: MovieModel(id: 550,
                                                     imdb_id: "tt0137523",
                                                     backdrop_path: "/8iVyhmjzUbvAGppkdCZPiyEHSoF.jpg",
                                                     poster_path: "/bptfVGEQuv6vDTIMVCHjJ9Dz8PX.jpg",
                                                     title: "Fight Club",
                                                     runtime: 139,
                                                     overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
                                                     release_date: "1999-10-15",
                                                     status: "Released",
                                                     adult: false,
                                                     vote_average: 8.4))
        }
    }
}


extension Content {
    
    func isAdded() -> Bool{
        let request: NSFetchRequest<StoredMovieModel> = StoredMovieModel.fetchRequest()
        let predicate = NSPredicate(format: "id == %i", Int32(movie.id!))
        request.predicate = predicate
        do {
            let results = try context.fetch(request)
            if results.count != 0 {
                return true
            }
        } catch {
            print("Error fetching data from context \(error)")
            return false
        }
        
        return false
        //        return results.count == 0 ? true : false
    }
    
    func deletefromCoreData() {
        let request: NSFetchRequest<StoredMovieModel> = StoredMovieModel.fetchRequest()
        let predicate = NSPredicate(format: "id == %i", Int32(movie.id!))
        request.predicate = predicate
        do {
            let results = try context.fetch(request)
            if results.count != 0 {
                context.delete(results[0])
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        do {
            try context.save()
            update?()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
    func writeToCoreData() {
        let movieToStore = StoredMovieModel(context: context)
        
        movieToStore.id = Int32(movie.id!)
        movieToStore.imdb_id = movie.imdb_id
        movieToStore.backdrop_path = movie.backdrop_path
        movieToStore.poster_path = movie.poster_path
        movieToStore.title = movie.title
        movieToStore.overview = movie.overview
        movieToStore.release_date = movie.release_date
        movieToStore.status = movie.status
        
        if let url = URL(string: MovieManager.getImageURL(from: movie.poster_path ?? "")) {
            if let data = try? Data(contentsOf: url) {
                movieToStore.poster = data
            }
        }
        
        if movie.runtime != nil {
            movieToStore.runtime = Int32(movie.runtime!)
        }
        if movie.adult != nil {
            movieToStore.adult = movie.adult!
        }
        if movie.vote_average != nil {
            movieToStore.vote_average = movie.vote_average!
        }
        
        do {
            try context.save()
            update?()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
}
