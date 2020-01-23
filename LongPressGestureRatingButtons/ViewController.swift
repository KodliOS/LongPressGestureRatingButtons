//
//  ViewController.swift
//  LongPressGestureRatingButtons
//
//  Created by Oguz on 23.01.2020.
//  Copyright © 2020 Oguz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StarRatingDelegate {

    private lazy var fiveStarControl = StarRating(frame: CGRect(x: 30, y: 100, width: 290, height: 50))
    
    private lazy var reset: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: 200, width: 100, height: 30))
        button.backgroundColor = .orange
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .regular)
        button.addTarget(self, action: #selector(resetScore1), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        fiveStarControl.delegate = self
        view.addSubview(fiveStarControl)
        view.addSubview(reset)
    }
    
    @objc func resetScore1() {
        fiveStarControl.rating = 0
    }
    
    func whatIsTheScore(_ ratingView: StarRating, result rating: Int) {
        print(rating)
    }
}
