//
//  DetailViewController.swift
//  w6d3-fetchedresultscontroller
//
//  Created by Roland on 2017-12-09.
//  Copyright © 2017 Roland. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    // MARK: - Public properties
    var detailItem: Meal? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}

// MARK: - UIViewController methods
extension DetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
}

// MARK: - Private methods
extension DetailViewController {
    
    private func configureView() {
        // Update the user interface for the detail item.
        if let detailItem = detailItem, let label = detailDescriptionLabel, let mealName = detailItem.name {
            label.text = "\(mealName) - \(detailItem.calories)"
        }
    }
}
