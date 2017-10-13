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
    var sets: [[Int]]
    
    init(name: String, sets: [[Int]]) {
        self.name = name
        self.sets = sets
        
        super.init()
    }
}
