//
//  SearchViewController.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/9/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Search controller to help us with filtering.
    var searchController: UISearchController!
    
    /// The search results table view.
    private var resultsTableController: ResultsTableController!
    
    var prompt: UIView?
    
    /// Restoration state for UISearchController
    //    var restoredState = SearchControllerRestorableState()
    
    
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = UIColor.init(named: "backgroundColor")
        navigationController?.navigationBar.prefersLargeTitles = true
        
        resultsTableController = ResultsTableController()
        searchController = UISearchController(searchResultsController: resultsTableController)
        
        searchController.delegate = self
//        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.searchBar.sizeToFit()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .words
        searchController.hidesNavigationBarDuringPresentation = true
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Movies"
    
        navigationItem.searchController = searchController
        prompt = Prompt.setupPrompt(in: view, title: "Search Movie by Name", detail: "Powered by The Movie Database.")
        
    }
    
}




// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let empty: [ResultModel] = []
        let resultsTableVC = searchController.searchResultsController as! ResultsTableController
        resultsTableVC.updateResults(from: empty)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let movieManager = MovieManager()
        let resultsTableVC = searchController.searchResultsController as! ResultsTableController
        if let text = searchBar.text {
            movieManager.search(for: text, call: resultsTableVC.updateResults)
        }
    }
    
}


// MARK: - UISearchControllerDelegate

extension SearchViewController: UISearchControllerDelegate {
    
    func presentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
}
