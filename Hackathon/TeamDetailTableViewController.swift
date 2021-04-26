//
//  TeamDetailTableViewController.swift
//  Hackathon
//
//  Created by Nipuni Obe on 4/26/21.
//

import UIKit
import MapKit


class TeamDetailTableViewController: UITableViewController {
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var universityField: UITextField!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    var team: Team!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if team == nil {
            team = Team()
        }
        updateUserInterface()
    }
    
    func updateUserInterface() {
        teamNameField.text = team.teamName
        universityField.text = team.university
        productNameField.text = team.projectName
        descriptionTextView.text = team.projectDescription
    }
    
    func updateFromUserInterface() {
        team.teamName = teamNameField.text!
        team.university = universityField.text!
        team.projectName = productNameField.text!
        team.projectDescription = descriptionTextView.text!
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromUserInterface()
        team.saveData { (success) in
            if success {
                self.leaveViewController()
            } else {
                print("*** ERROR: couldn't leave this view controller bc data wasn't saved")
            }
        }
    }
    
}
