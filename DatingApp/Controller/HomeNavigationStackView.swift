//
//  HomeNavigationStackView.swift
//  DatingApp
//
//  Created by Jack in a box on 14/08/2021.
//

import Foundation
import UIKit


class HomeNavigationStackView: UIStackView {
    
    
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let tinderIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        tinderIcon.contentMode = .scaleAspectFit
        
        settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_messages_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [settingsButton, UIView(), tinderIcon, UIView(), messageButton].forEach {
            view in addArrangedSubview(view)
        }
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        settingsButton.addTarget(self, action: #selector(handleShowSettings), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(handleShowMessages), for: .touchUpInside)
        
    }
    
    required init(coder: NSCoder) {
           fatalError("init(coder:) has nt been implemented")
        
    }
    
    @objc func handleShowSettings() {
        print("test")
    }
    
    @objc func handleShowMessages() {
        print("test")
    }
}
