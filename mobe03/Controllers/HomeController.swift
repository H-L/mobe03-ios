//
//  ViewController.swift
//  mobe03
//
//  Created by Hadrien Lepoutre on 19/12/2017.
//  Copyright © 2017 Hadrien Lepoutre. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
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
        
        // CollectionView Setup
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.backgroundColor = UIColor.white
        
        // Functions launched when view is Loaded
        checkIfUserIsLoggedIn()
        setUpMenuBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
            sub.uid = snapshot.key
            
            print(self.subs)
            
            if self.subs.contains(sub) {
                return
            } else {
                self.subs.append(sub)
            }
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        }, withCancel: nil)
    }
    
    // Pretty obvious title, duh
    func checkIfUserIsLoggedIn() {
        if subs.count != 0 {
            subs = [Subscription]()
        }
        
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(handleLogOut), with: nil, afterDelay: 0)
            print("User needs to log in")
        }
        else {
            self.userId = Auth.auth().currentUser?.uid
            fetchSub()
        }
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setUpMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[view0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[view0(50)]", views: menuBar)
    }
    
    /*
    / ===== COLLECTION VIEW FUNCTIONS ====
    */
    
    // Manage number of Cells in Collection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subs.count
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return subs.count
//    }
    
    // Add cells to Collection
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SubscriptionCell
        cell.sub = subs[indexPath.row]
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
//        let sub = subs[indexPath.row]
//        cell.textLabel?.text = sub.name
//        return cell
//    }
    
    // Manage size of the Cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("A row \(indexPath) has been selected")
//        let sub = subs[indexPath.row]
//        let singleSubController = SingleSubController()
//        singleSubController.sub = sub
//        self.navigationController?.pushViewController(singleSubController, animated: true)
//    }
    
    // Manage View launched when clicking on a CollectionCell
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("A row \(indexPath) has been selected")
        let sub = subs[indexPath.row]
        let singleSubController = SingleSubController()
        singleSubController.sub = sub
        self.navigationController?.pushViewController(singleSubController, animated: true)
    }
    
    // Manage Spacing between cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

