//
//  QuestLogDataSource.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 6/30/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class QuestLogDataSource: NSObject, UITableViewDataSource {
    var quests: [Quest] = []
    
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogEntryTableViewCell", for: indexPath)
        print("successfully added Quest to log")
        let quest = quests[indexPath.row]
        
//        cell.textLabel?.font = UILabel.appearance().font.withSize(CGFloat(20))
        cell.textLabel?.text = quest.title
        cell.detailTextLabel?.text = dateFormatter.string(from: quest.date)
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        quests.remove(at: indexPath.row)
        tableView.reloadData()
    }
}
