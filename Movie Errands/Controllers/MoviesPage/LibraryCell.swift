//
//  LibraryCell.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/14/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import UIKit

class LibraryCell: UICollectionViewCell {

    static var identifier: String = "Cell"
    
    var address: String?

//    weak var textLabel: UILabel!
    weak var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView(frame: .zero)
        
//        guard let url = URL(string: "http://myImage.com/image.png") else { return }
//        UIImage.loadFrom(url: url) { image in
//            self.imageView.image = image
//        }
        imageView.image = UIImage.imageWithColor(color: UIColor.gray)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 7
        imageView.layer.masksToBounds = true
        
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: imageView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            self.contentView.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: imageView.rightAnchor),
        ])
        
        self.imageView = imageView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(with address: String) {

        // Perform on background thread
        DispatchQueue.global().async {

            // Create url from string address
            guard let url = URL(string: address) else {
                return
            }

            // Create data from url (You can handle exeption with try-catch)
            guard let data = try? Data(contentsOf: url) else {
                return
            }

            // Create image from data
            guard let image = UIImage(data: data) else {
                return
            }

            // Perform on UI thread
            DispatchQueue.main.async {
                self.imageView.image = image
                /* Do some stuff with your imageView */
            }
        }
    }

}
