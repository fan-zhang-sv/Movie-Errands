//
//  MoviesViewController.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/9/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

class MoviesViewController: UICollectionViewController {
    
    var movies: [StoredMovieModel] = []
    let cellID = "collectionCellID"
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var prompt: UIView?
    
    var numberOfColumn: Int {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation.isLandscape {
                return 5
            } else {
                return 4
            }
        } else {
            return 2
        }
    }
    
    var nextNumberOfColumn: Int {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation.isLandscape {
                return 4
            } else {
                return 5
            }
        } else {
            return 5
            
        }
    }
    
    var interspace: Int {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 30
        } else {
            return 20
        }
    }
    
    var linespace: Int {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 30
        } else {
            return 20
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Movie Errands"
        view.backgroundColor = UIColor.init(named: "backgroundColor")
        collectionView.backgroundColor = UIColor.init(named: "backgroundColor")
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView?.contentInsetAdjustmentBehavior = .always
        collectionView?.alwaysBounceVertical = true
        collectionView?.bounces = true
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 22, bottom: 10, right: 22)
        collectionView.register(LibraryCell.self, forCellWithReuseIdentifier: cellID)
        
        prompt = Prompt.setupPrompt(in: view, title: "No Movies", detail: "Your library is empty. Movies that you add to your library will appear here.")
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    
    func reloadMovieData() {
        let request: NSFetchRequest<StoredMovieModel> = StoredMovieModel.fetchRequest()
        
        do {
            movies = try context!.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
        
        if movies.count == 0 {
            collectionView.isHidden = true
            prompt?.isHidden = false
        } else {
            collectionView.isHidden = false
            prompt?.isHidden = true
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //        tabBarController?.overrideUserInterfaceStyle = .dark
        super.viewWillAppear(animated)
        reloadMovieData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = getWidth()
            let height = Int(Double(width) * 1.5)
            layout.itemSize = CGSize(width: width, height: height)
            layout.invalidateLayout()
        }
    }
    
}

//MARK: - UICollectionViewDataSource, UICollectionDelegate

extension MoviesViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! LibraryCell
        let item = movies[indexPath.row]
        if let data = item.poster {
            cell.imageView.image = UIImage(data: data)
        }
//        cell.loadImage(with: MovieManager.getImageURL(from: item.poster_path ?? ""))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = movies[indexPath.row]
        let movie = MovieModel(id: Int(item.id),
                               imdb_id: item.imdb_id,
                               backdrop_path: item.backdrop_path,
                               poster_path: item.poster_path,
                               title: item.title,
                               runtime: Int(item.runtime),
                               overview: item.overview,
                               release_date: item.release_date,
                               status: item.status,
                               adult: item.adult,
                               vote_average: item.vote_average)
        
        if let contentVC = MovieDetailViewController(movie: movie, update: reloadMovieData) {
            contentVC.hidesBottomBarWhenPushed = true
            self.present(contentVC, animated: true, completion: nil)
        }
        
        //        navigationController?.pushViewController(contentVC, animated: true)
    }
    
}


//MARK: - UICollectionViewDelegateFlowLayout

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func getWidth() -> Int{
        let insets = Int(view.safeAreaInsets.left + view.safeAreaInsets.right)
        let width = (Int(collectionView.bounds.width) - 44 - insets - interspace * (numberOfColumn - 1)) / numberOfColumn
        return width
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = getWidth()
        let height = Int(Double(width) * 1.5)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(interspace)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(linespace)
    }
}


