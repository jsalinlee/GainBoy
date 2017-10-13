//
//  EntryDetailsViewController.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 10/5/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class EntryDetailsViewController: UITableViewController {
    var backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        self.tableView.backgroundColor = backgroundColor
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryDetailCell", for: indexPath)
        cell.backgroundColor = backgroundColor
        return cell
    }
}
