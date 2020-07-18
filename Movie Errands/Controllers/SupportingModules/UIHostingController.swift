//
//  UIHostingController.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/18/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import SwiftUI

final class MovieDetailViewController: UIHostingController<MovieDetailSwiftUIView> {
    
    required init?(movie: MovieModel, update: (() -> Void)?) {
        super.init(rootView: MovieDetailSwiftUIView(movie: movie, update: update))
        rootView.dismiss = dismiss
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
        
    }
}
