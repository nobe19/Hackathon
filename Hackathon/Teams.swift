//
//  Teams.swift
//  Hackathon
//
//  Created by Nipuni Obe on 4/26/21.
//

import Foundation
import Firebase

class Teams {
    var teamArray: [Team] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore() //issue here
        
    }
    
    func loadData(completed: @escaping() -> ()) {
        db.collection("teams").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("😡 ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.teamArray = [] //clean out existing spotArray since new data will load
            for document in querySnapshot!.documents {
                // make sure to have a dictionary initializer in the singular class
                let team = Team(dictionary: document.data())
                team.documentID = document.documentID
                self.teamArray.append(team)
            }
            completed()
        }
    }
}
