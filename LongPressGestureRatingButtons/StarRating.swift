//
//  File.swift
//  LongPressGestureRatingButtons
//
//  Created by Oguz on 23.01.2020.
//  Copyright © 2020 Oguz. All rights reserved.
//

import UIKit

protocol StarRatingDelegate:class {
    func whatIsTheScore(_ ratingView: StarRating, result rating: Int)
}

final class StarRating: UIStackView {
    
    weak var delegate: StarRatingDelegate?
    
    private var ratingButtons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        spacing = 10
        setUpButtons()
    }
    
    var rating: Int = 0 {
        didSet { updateButtonSelectionState() }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 0..<5 {
            let button = UIButton()
            button.backgroundColor = .clear
            button.setImage(#imageLiteral(resourceName: "star1-0"), for: .normal)
            button.setImage(#imageLiteral(resourceName: "star1-3"), for: .selected)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionState()
        let gr = UILongPressGestureRecognizer(target: self, action: #selector(handleSelection(_:)))
        gr.minimumPressDuration = 0
        addGestureRecognizer(gr)
    }
    
    @objc func handleSelection(_ press: UILongPressGestureRecognizer) {
        
        let location = press.location(in: self.superview)
        detechWhichStar(location: location)
        print(location)
    }
    
    private func detechWhichStar(location: CGPoint) {
        
        for (index, button) in ratingButtons.enumerated() {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            let frame = button.convert(button.bounds, to: self.superview)
            if frame.contains(CGPoint(x: location.x, y: self.frame.origin.y)) {
                
                if rating != index + 1 {
                    generator.selectionChanged()
                    delegate?.whatIsTheScore(self, result: index+1)
                    print(index)
                }
                rating = index + 1
            }
        }
    }
    
    private func updateButtonSelectionState() {
        for (index,button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}

