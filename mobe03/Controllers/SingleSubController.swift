//
//  SingleSubController.swift
//  mobe03
//
//  Created by Hadrien Lepoutre on 21/12/2017.
//  Copyright © 2017 Hadrien Lepoutre. All rights reserved.
//

import UIKit

class SingleSubController: UIViewController, UITextFieldDelegate {
    
    var sub: Subscription? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = sub?.name
    }
    
    @objc func handleGoBack() {
        dismiss(animated: true, completion: nil)
    }
}
