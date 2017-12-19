//
//  ViewController.swift
//  mobe03
//
//  Created by Hadrien Lepoutre on 19/12/2017.
//  Copyright © 2017 Hadrien Lepoutre. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    @objc func handleLogOut() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }

}

