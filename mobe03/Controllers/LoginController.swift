//
//  LoginController.swift
//  mobe03
//
//  Created by Hadrien Lepoutre on 19/12/2017.
//  Copyright © 2017 Hadrien Lepoutre. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 39, g: 100, b: 98)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
