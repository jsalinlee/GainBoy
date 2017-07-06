//
//  AdventureLogDataSource.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 6/30/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class AdventureLogDataSource: NSObject, UITableViewDataSource {
    var adventures: [Adventure] = []
    
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adventures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogEntryTableViewCell", for: indexPath)
        print("successfully added Adventure to log")
        let adventure = adventures[indexPath.row]
        cell.textLabel?.text = dateFormatter.string(from: adventure.date)
        cell.detailTextLabel?.text = adventure.title
        
        return cell
    }
}
