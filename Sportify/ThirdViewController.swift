//
//  ThirdViewController.swift
//  Sportify
//
//  Created by Richard Kolen on 18-06-15.
//  Copyright (c) 2015 Richard Kolen. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var trainingText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var trainingImage: UIImageView!
    
    var recievedTrainingText: String = ""
    var recievedDescriptionText: String = ""
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        trainingText.text = recievedTrainingText
        descriptionText.text = recievedDescriptionText
        
        self.trainingImage.image = UIImage(named: recievedTrainingText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
