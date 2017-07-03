//
//  MainMenuViewController.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 6/30/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var healthLabel: UILabel!
    @IBOutlet var experienceLabel: UILabel!
    @IBOutlet var goldLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    
    var health: Double = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLog" {
            
        }
    }
    
}
