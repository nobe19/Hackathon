//
//  TeamsListViewController.swift
//  Hackathon
//
//  Created by Nipuni Obe on 4/26/21.
//

import UIKit

class TeamsListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var teams = ["Hodors Coders", "The Swiftettes", "Ada's Playground", "Bug Crushers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TeamsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = teams[indexPath.row]
        return cell
    }
    
    
}
