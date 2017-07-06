//
//  Adventure.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 6/30/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class Adventure: NSObject {
    var title: String
    var date: Date
    var time: Date
    var weight: Double
    var exercises: [Exercise]
    var id: String?
    
    init(title: String, date: Date, time: Date, weight: Double, exercises: [Exercise]) {
        self.title = title
        self.date = date
        self.time = time
        self.weight = weight
        self.exercises = exercises
        self.id = UUID().uuidString.components(separatedBy: "-").first!
        
        super.init()
    }
}
