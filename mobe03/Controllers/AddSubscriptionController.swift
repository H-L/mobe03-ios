//
//  AddSubscriptionController.swift
//  mobe03
//
//  Created by Hadrien Lepoutre on 20/12/2017.
//  Copyright © 2017 Hadrien Lepoutre. All rights reserved.
//

import UIKit
import Firebase

class AddSubscriptionController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
        print("Add subscription has been canceled")
    }

}
