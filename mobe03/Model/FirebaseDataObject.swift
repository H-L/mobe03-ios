//
//  FirebaseDataObject.swift
//  mobe03
//
//  Created by Hadrien Lepoutre on 20/12/2017.
//  Copyright © 2017 Hadrien Lepoutre. All rights reserved.
//

import UIKit
import Firebase

class FirebaseDataObject: NSObject {
    let snapshot: DataSnapshot
    @objc var key: String { return snapshot.key }
    var ref: DatabaseReference { return snapshot.ref }
    
    required init(snapshot: DataSnapshot) {
        
        self.snapshot = snapshot
        
        super.init()
        
        for child in snapshot.children.allObjects as? [DataSnapshot] ?? [] {
            if responds(to: Selector(child.key)) {
                setValue(child.value, forKey: child.key as String!)
            }
        }
    }
}
