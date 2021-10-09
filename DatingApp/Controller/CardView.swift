//
//  CardView.swift
//  DatingApp
//
//  Created by Jack in a box on 14/08/2021.
//
import UIKit
import SDWebImage

// swiping direction
enum SwipDirection: Int {
    case left = -1
    case right = 1
}


class CardView: UIView {
    
    private let gradiantLayer = CAGradientLayer()
    private let viewModel: CardViewModel
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    // label onder de foto
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        //label.attributedText = CardViewModel.userInfoText
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "dismiss_down_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        configureGestureRecognizers()
        
        infoLabel.attributedText = viewModel.userInfoText
        
//        imageView.image = viewModel.user.images.first
        
        imageView.sd_setImage(with: viewModel.imageUrl )
        
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        //GradientLayer (dark layer)
        configureGradientLayer()
        
        addSubview(infoLabel)
        infoLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        addSubview(infoButton)
        infoButton.setDimensions(height: 40, width: 40)
        infoButton.centerY(inView: infoLabel)
        infoButton.anchor(right: rightAnchor, paddingRight: 16)
        
       
        
    }
    
    override func layoutSubviews() {
        gradiantLayer.frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        print("DEBUG: translation x is \(translation.x)")
        print("DEBUG: translation y is \(translation.y)")
        
        switch sender.state {
        case .began:
            //remove all the previous animation after mass swip
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
        case .changed:
            panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
            print("DEBUG: Pan ended..")
        default:
            break
        }
    }
    
    
    @objc func handleChangePhoto(sender: UITapGestureRecognizer) {
    //tapped on the left or right option
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > self.frame.width / 2
        
        //show where tapped left or right
        print("DEBUG: Location is \(location)")
        //Treshhold is the middel
        print("DEBUG: Treshhold value is \(self.frame.width / 2)")
        print("DEBUG: Should show next photo is \(shouldShowNextPhoto)")
        
        if shouldShowNextPhoto {
            viewModel.showNextPhoto()
        } else {
            viewModel.showPreviousPhoto()
        }
        
        //imageView.image = viewModel.imageToShow
        
    }
    
    func panCard(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    func resetCardPosition(sender: UIPanGestureRecognizer) {
        
        // move the card 100% to the left or right
        let direction: SwipDirection = sender.translation(in: nil).x > 100 ? .right : .left
        // when whiping a card more than 100% it will dismiss the card.
        let shouldDismisscard = abs(sender.translation(in: nil).x) > 100
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            // off screen when completely the card is completely moved
            if shouldDismisscard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
            } else {
                self.transform = .identity
            }
        }) { _ in
            if shouldDismisscard {
                self.removeFromSuperview()
            }
        }
    }
    
    // darkness below the card
    func configureGradientLayer() {
        gradiantLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradiantLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradiantLayer)
        gradiantLayer.frame = self.frame
    }
    

    func configureGestureRecognizers() {
        
        ////Pan is the gesture to the left or right
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        
        //Handle Change foto with tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
    }
}
