//
//  Team.swift
//  Hackathon
//
//  Created by Nipuni Obe on 4/26/21.
//

import Foundation
import MapKit
import Firebase

class Team {
    var teamName: String
    var university: String
    var coordinate: CLLocationCoordinate2D
    var projectName: String
    var projectDescription: String
    var createdOn: Date
    var postingUserID: String
    var documentID: String
    
    var latitude: CLLocationDegrees {
        return coordinate.latitude
    }
    
    var longitude: CLLocationDegrees {
        return coordinate.longitude
    }
    
    var dictionary: [String: Any] {
        let timeIntervalDate = createdOn.timeIntervalSince1970
        return ["teamName": teamName, "university": university, "latitude": latitude, "longitude": longitude, "projectName": projectName, "projectDescription": projectDescription, "createdOn": timeIntervalDate, "postingUserID": postingUserID]
    }
    
    init(teamName: String, university: String, coordinate: CLLocationCoordinate2D, projectName: String, projectDescription: String, createdOn: Date, postingUserID: String, documentID: String) {
        self.teamName = teamName
        self.university = university
        self.coordinate = coordinate
        self.projectName = projectName
        self.projectDescription = projectDescription
        self.createdOn = createdOn
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(teamName: "", university: "", coordinate: CLLocationCoordinate2D(), projectName: "", projectDescription: "", createdOn: Date(), postingUserID: "", documentID: "")
    }
    
    func saveData(completion: @escaping  (Bool) -> ()) {
        let db = Firestore.firestore()
        //grab user ID
        guard let postingUserID = Auth.auth().currentUser?.uid else {
            print("😡 ERROR: Could not save data bc we don't have a valid User ID")
            return completion(false)
        }
        self.postingUserID = postingUserID
        //create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        //if we HAVE saved a record, we'll have an ID, otherwise .addDocument will create one
        if self.documentID == "" { //create a new doc via .addDocument
            var ref: DocumentReference? = nil //firestore will create a new ID for us
            ref = db.collection("teams").addDocument(data: dataToSave){ (error) in
                guard error == nil else {
                    print("😡 ERROR: adding document \(error!.localizedDescription)")
                    return completion(false)
                }
                self.documentID = ref!.documentID
                print("💨 Added document: \(self.documentID)") //it worked!
                completion(true)
            }
        } else { //else save to the existing documentID w/ .setData
            let ref = db.collection("spots").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                guard error == nil else {
                    print("😡 ERROR: updating document \(error!.localizedDescription)")
                    return completion(false)
                }
                print("💨 Updated document: \(self.documentID)") //it worked!
                completion(true)
            }
        }
    }
    
}
