//
//  ViewController.swift
//  mobe03
//
//  Created by Hadrien Lepoutre on 19/12/2017.
//  Copyright © 2017 Hadrien Lepoutre. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UITableViewController {
    
    // Global View vars
    var dbref: DatabaseReference!
    let cellId = "cellID"
    var userId = Auth.auth().currentUser?.uid

    var subs = [Subscription]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DB Reference
        self.dbref = Database.database().reference()
        
        // Navigation Items
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOut))
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(handleAddSub))
        
        // Functions launched when view is Loaded
        checkIfUserIsLoggedIn()
    }
    
    /*
     / ===== #SELECTOR FUNCTIONS ====
    */
    
    // Log user out
    @objc func handleLogOut() {

        do {
            try Auth.auth().signOut()
        } catch let logOutError {
            print(logOutError)
        }

        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    // Go to AddSubscriptionController
    @objc func handleAddSub() {
        print("Adding sub")
        let addSubController = AddSubscriptionController()
        let navigationController = UINavigationController(rootViewController: addSubController)
        present(navigationController, animated: true, completion: nil)
    }
    
    /*
    / ===== CLASSIC FUNCTIONS ====
    */
    
    // Get all subscriptions from DB
    func fetchSub() {
        dbref.child("subscription").child(userId!).observe(.childAdded, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            let sub = Subscription()
            
            sub.contractNumber = postDict["contractNumber"] as? String
            sub.date = postDict["date"] as? String
            sub.dateEnd = postDict["dateEnd"] as? String
            sub.name = postDict["name"] as? String
            sub.price = postDict["price"] as? String
            sub.subDescription = postDict["subDescription"] as? String
            
            self.subs.append(sub)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }, withCancel: nil)
    }
    
    // Pretty obvious title, duh
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(handleLogOut), with: nil, afterDelay: 0)
            print("User needs to log in")
        }
        else {
            self.userId = Auth.auth().currentUser?.uid
            fetchSub()
        }
    }
    
    /*
    / ===== TABLE VIEW FUNCTIONS ====
    */
    
    // TableView props
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let sub = subs[indexPath.row]
        cell.textLabel?.text = sub.name
        return cell
    }

}

