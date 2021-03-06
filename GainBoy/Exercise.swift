//
//  Exercise.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 6/30/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class Exercise: NSObject {
    var name: String
    var reps: [Int]
    var weights: [Double]
    
    init(name: String, reps: [Int], weights: [Double]) {
        self.name = name
        self.reps = reps
        self.weights = weights
        
        super.init()
    }
}
