//
//  showPrompt.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/13/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import UIKit

struct Prompt {
    
    static func setupPrompt(in view: UIView, title: String, detail: String, imageName: String? = nil) -> UIView{
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        view.addSubview(stack)
        
        let primaryPrompt = UILabel()
        primaryPrompt.text = title
        primaryPrompt.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        primaryPrompt.textAlignment = .center
        primaryPrompt.adjustsFontSizeToFitWidth = false
        
        stack.addSubview(primaryPrompt)
        
        let secondPrompt = UILabel()
        secondPrompt.text = detail
        secondPrompt.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        secondPrompt.textColor = .systemGray
        secondPrompt.textAlignment = .center
        secondPrompt.numberOfLines = 0
        secondPrompt.adjustsFontSizeToFitWidth = false
        
        stack.addSubview(secondPrompt)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        primaryPrompt.translatesAutoresizingMaskIntoConstraints = false
        primaryPrompt.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        primaryPrompt.centerXAnchor.constraint(equalTo: stack.centerXAnchor).isActive = true
        
        secondPrompt.translatesAutoresizingMaskIntoConstraints = false
        secondPrompt.topAnchor.constraint(equalTo: primaryPrompt.bottomAnchor, constant: 10).isActive = true
        secondPrompt.bottomAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
        secondPrompt.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 25).isActive = true
        secondPrompt.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -25).isActive = true
        
        if imageName != nil {
            let image = UIImageView()
            image.image = UIImage(named: "tmdb")
            stack.addSubview(image)
            
        }
        
        return stack
    }

}

