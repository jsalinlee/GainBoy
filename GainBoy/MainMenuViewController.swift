//
//  MainMenuViewController.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 6/30/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenuViewController: UIViewController {
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var healthLabel: UILabel!
    @IBOutlet var experienceLabel: UILabel!
    @IBOutlet var goldLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    
    var health: Double = 100.0
    
    @IBOutlet var exercisesButton: UIButton!
    @IBOutlet var questLogButton: UIButton!
    @IBOutlet var rewardsButton: UIButton!
    @IBOutlet var statsButton: UIButton!
    
    @IBOutlet var statusSKView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
//        UILabel.appearance().substituteFontName = "Cochin"
        UILabel.appearance(whenContainedInInstancesOf: [UITextField.self]).textColor = UIColor(red: 43 / 255, green: 63 / 255, blue: 106 / 255, alpha: 0.4)
//        UITextView.appearance().substituteFontName = "Cochin"
//        UITextField.appearance().substituteFontName = "Cochin"
        
//        func printFonts() {
//            let fontFamilyNames = UIFont.familyNames
//            for familyName in fontFamilyNames {
//                print("------------------------------")
//                print("Font Family Name = [\(familyName)]")
//                let names = UIFont.fontNames(forFamilyName: familyName as! String)
//                print("Font Names = [\(names)]")
//            }
//        }
//        printFonts()
        var statusScene = MainMenuStatusScene()
        
        statusScene.scaleMode = .resizeFill
        statusSKView.presentScene(statusScene)

    }
    
    @IBAction func showLog(_ sender: UIButton) {
        performSegue(withIdentifier: "showLog", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLog" {
            
        }
    }
    
    func menuButtonFormatting(menuButton: UIButton) {
        menuButton.imageView?.contentMode = .scaleAspectFit
        let buttonSize = menuButton.frame.size
        let titleSize = menuButton.titleLabel?.frame.size
        let imageSize = menuButton.imageView?.frame.size
        
        menuButton.titleEdgeInsets = UIEdgeInsetsMake((buttonSize.height / 1.75) + 5, -(imageSize?.width)! + ((buttonSize.width - (titleSize?.width)!) / 2), 0.0, 0.0)
        menuButton.imageEdgeInsets = UIEdgeInsetsMake((buttonSize.height / 5), ((buttonSize.width - (imageSize?.width)!) / 2), 0.0, 0.0)
    }
}
