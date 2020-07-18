//
//  MovieManager.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/10/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MovieManager {
    var buffer: [ResultModel] = []
    var castsBuffer: [CastModel] = []
    var movieBuffer: MovieModel?
    
    let openBase = "https://api.themoviedb.org/3/movie"
    let searchBase = "https://api.themoviedb.org/3/search/movie"
    var apiKey: String {
        var keys: NSDictionary?
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
               keys = NSDictionary(contentsOfFile: path)
           }
        if let dict = keys {
                guard let key = dict["api_key"] as? String else { return "" }
                return "?api_key=" + key
        }
        
        return ""
    }

    
    //MARK: - imageURL
    
    public static let imageURL: String = "https://image.tmdb.org/t/p/w500"
    
    static func getImageURL(from link: String) -> String {
        return imageURL + link
    }
    
    public static let bgURL: String = "https://image.tmdb.org/t/p/original"
    
    static func getBGURL(from link: String) -> String {
        return bgURL + link
    }
    
    //MARK: - IMDbURL
    
    public static let imdbURL: String = "https://www.imdb.com/title"
    
    static func getIMDbURL(from link: String) -> String {
        return imdbURL + "/" + link
    }

    
    //MARK: - Search for Movies

    
    func search(for name: String, call callback: @escaping ([ResultModel]) -> () ) {
        let url = searchBase + apiKey + "&query=" + name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        self.buffer = []
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                json["results"].arrayValue.forEach { (movie) in
                    let thisMovie = ResultModel(id: movie["id"].int,
                                               poster_path: movie["poster_path"].string,
                                               title: movie["title"].string)
                    self.buffer.append(thisMovie)
                }
                callback(self.buffer)
                break
            case .failure(let error):
                print("error:\(error)")
                break
            }
        }
    }
    
    //MARK: - Open Movie Profile
    
    func open(for id: Int, call callback: @escaping (MovieModel) -> () ) {
        movieBuffer = nil
        let url = openBase + "/" + String(id) + apiKey
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let movie = JSON(value)
                let thisMovie = MovieModel(id: movie["id"].int,
                                           imdb_id: movie["imdb_id"].string,
                                           backdrop_path: movie["backdrop_path"].string,
                                           poster_path: movie["poster_path"].string,
                                           title: movie["title"].string,
                                           runtime: movie["runtime"].int,
                                           overview: movie["overview"].string,
                                           release_date: movie["release_date"].string,
                                           status: movie["status"].string,
                                           adult: movie["adult"].boolValue,
                                           vote_average: movie["vote_average"].double)
                self.movieBuffer = thisMovie
                if let safeMovie = self.movieBuffer {
                    callback(safeMovie)
                }
                break
            case .failure(let error):
                print("error:\(error)")
                break
            }
        }
    }
    
    
    //MARK: - Get Similar Movies
    
    func getRelatedMovies(for id: Int, call callback: @escaping ([ResultModel]) -> () ) {
        let url = openBase + "/\(id)/similar" + apiKey
        self.buffer = []
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                json["results"].arrayValue.forEach { (movie) in
                    let thisMovie = ResultModel(id: movie["id"].int,
                                               poster_path: movie["poster_path"].string,
                                               title: movie["title"].string)
                    self.buffer.append(thisMovie)
                }
                if self.buffer.count >= 5 {
                    callback(Array(self.buffer[0...4]))
                } else {
                    callback(self.buffer)
                }
                break
            case .failure(let error):
                print("error:\(error)")
                break
            }
        }
    }
    
    //MARK: - Get Cast
    
    
    func getCasts(for id: Int, call callback: @escaping ([CastModel]) -> () ) {
        let url = openBase + "/\(id)/credits" + apiKey
        self.castsBuffer = []
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                json["cast"].arrayValue.forEach { (movie) in
                    let thisCast = CastModel(cast_id: movie["cast_id"].int,
                                             character: movie["character"].string,
                                             name: movie["name"].string,
                                             profile_path: movie["profile_path"].string)
                    self.castsBuffer.append(thisCast)
                }
                if self.castsBuffer.count >= 10 {
                    callback(Array(self.castsBuffer[0...9]))
                } else {
                    callback(self.castsBuffer)
                }
                break
            case .failure(let error):
                print("error:\(error)")
                break
            }
        }
    }
    
}


