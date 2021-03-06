//
//  TeamsListViewController.swift
//  Hackathon
//
//  Created by Nipuni Obe on 4/26/21.
//

import UIKit

class TeamsListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var teams: Teams!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        teams = Teams()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        teams.loadData {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier = "ShowTeam" {
            let destination = segue.destination as! TeamDetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.team = teams.teamArray[selectedIndexPath.row]
        }
    }
}

extension TeamsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.teamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = teams.teamArray[indexPath.row].teamName
        return cell
    }
}
