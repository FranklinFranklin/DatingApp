//
//  ButtomControlsStackView.swift
//  DatingApp
//
//  Created by Jack in a box on 14/08/2021.
//

import Foundation
import UIKit

class ButtomControlsStackView: UIStackView {
    
    
    let refreshButton = UIButton(type: .system)
    let dislikeButton = UIButton(type: .system)
    let superlikeButton = UIButton(type: .system)
    let likeButton = UIButton(type: .system)
    let boostButton = UIButton(type: .system)
    
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        // all buttoms the same hight
        distribution = .fillEqually
        
        refreshButton.setImage(#imageLiteral(resourceName: "refresh_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        dislikeButton.setImage(#imageLiteral(resourceName: "dismiss_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        superlikeButton.setImage(#imageLiteral(resourceName: "super_like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.setImage(#imageLiteral(resourceName: "like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        boostButton.setImage(#imageLiteral(resourceName: "boost_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        
            
        // stackview, set the view within ,icon space icon spce >> Add each to my stack view
        [refreshButton, dislikeButton, superlikeButton, likeButton, boostButton].forEach {
            view in addArrangedSubview(view)
         
        }
        
    }
    
    required init(coder: NSCoder) {
           fatalError("init(coder:) has nt been implemented")
    }
}
