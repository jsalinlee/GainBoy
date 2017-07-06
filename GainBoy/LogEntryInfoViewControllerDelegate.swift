//
//  LogEntryInfoViewControllerDelegate.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 6/30/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

protocol LogEntryInfoViewControllerDelegate: class {
    func cancelButtonPressed(by controller: LogEntryInfoViewController)
    func addAdventure(by controller: LogEntryInfoViewController, t title: String, d date: Date, time: Date, w weight: Double, e exercises: [Exercise], indexPath: IndexPath?)
}
