//
//  ResultsTableViewController.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/9/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import UIKit
import SwiftUI

class ResultsTableController: UITableViewController {
    
    var results: [ResultModel] = []
    
    public func updateResults(from array: [ResultModel]) {
        self.results = array
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "backgroundColor")
        
        tableView.register(HostingTableViewCell<TabelCellSwiftUIView>.self, forCellReuseIdentifier: "videoCellID")
        tableView.separatorStyle = .none
        
        if UIDevice.current.userInterfaceIdiom == .pad {
//            tableView.contentInset = UIEdgeInsets(top: 25, left: 50, bottom: 25, right: 50)
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 500).isActive = true
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCellID") as! HostingTableViewCell<TabelCellSwiftUIView>
        cell.host(TabelCellSwiftUIView(title: results[indexPath.row].title ?? "non", imageURLString: MovieManager.getImageURL(from: results[indexPath.row].poster_path ?? "")), parent: self)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let id = results[indexPath.row].id {
            let movieManager = MovieManager()
            movieManager.open(for: id, call: openMovie)
        }
    }
    
    
    
    
    func openMovie(for movie: MovieModel) {
//        let contentVC = UIHostingController(rootView: MovieDetailSwiftUIView(movie: movie, dismiss: {self.dismiss( animated: true, completion: nil )}))
//        self.present(contentVC, animated: true, completion: nil)
        if let contentVC = MovieDetailViewController(movie: movie, update: nil) {
            contentVC.hidesBottomBarWhenPushed = true
            self.present(contentVC, animated: true, completion: nil)
        }
    }
    
}

