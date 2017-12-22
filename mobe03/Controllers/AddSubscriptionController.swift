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
    
    var dbref: DatabaseReference!
    var userId = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbref = Database.database().reference(fromURL: "https://mobe03-dev.firebaseio.com/")
        
        view.addSubview(autoManualField)
        view.addSubview(nameField)
        view.addSubview(contractNumberField)
        view.addSubview(dateField)
        view.addSubview(dateEndField)
        view.addSubview(subDescriptionField)
        view.addSubview(priceField)
        view.addSubview(typeField)
        
        view.addSubview(addButton)
        
        setUpTextFields()

        view.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.title = "Add Subscription"
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
        print("Add subscription has been canceled")
    }
    
    @objc func handleAddSubscription() {
        // Input validation
        guard
            let name = nameField.text,
            let date = dateField.text,
            let dateEnd = dateEndField.text,
            let price = priceField.text,
            let subDescription = subDescriptionField.text,
            let type = typeField.text
        else {
            print("Something")
            return
        }
        
        // Update to FDB
        let values = [
            "autoManual": "true",
            "name": name,
            "date": date,
            "dateEnd": dateEnd,
            "price": price,
            "subDescription": subDescription,
            "type": type
        ]
        
        dbref.child("subscription").child(userId!).childByAutoId().updateChildValues(values) { (error: Error?, ref ) in
            if error != nil {
                print(error as Any)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
            
            print("Subscription added to FDB")
        }
        
        // FAnalytics
        Analytics.logEvent("add_subscription", parameters: [
            "user_id": userId!,
            "name": name,
            "price": price,
            "start_date": date,
            "is_custom": "true"
        ])
    }
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Subscription", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(r: 120, g: 159, b: 227)
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(handleAddSubscription), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.textColor = UIColor.black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let autoManualField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Automatic / Manual"
        tf.textColor = UIColor.black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let contractNumberField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Contract Number"
        tf.textColor = UIColor.black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let dateField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Date"
        tf.textColor = UIColor.black
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        tf.inputView = datePicker
            
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let dateEndField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Date End"
        tf.textColor = UIColor.black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let subDescriptionField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Description"
        tf.textColor = UIColor.black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let priceField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Price"
        tf.textColor = UIColor.black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let typeField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Subscription Type"
        tf.textColor = UIColor.black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    func setUpTextFields() {
        autoManualField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        autoManualField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        autoManualField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        autoManualField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameField.topAnchor.constraint(equalTo: autoManualField.bottomAnchor).isActive = true
        nameField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dateField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateField.topAnchor.constraint(equalTo: nameField.bottomAnchor).isActive = true
        dateField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        dateField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dateEndField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateEndField.topAnchor.constraint(equalTo: dateField.bottomAnchor).isActive = true
        dateEndField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        dateEndField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        priceField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        priceField.topAnchor.constraint(equalTo: dateEndField.bottomAnchor).isActive = true
        priceField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        priceField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        typeField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        typeField.topAnchor.constraint(equalTo: priceField.bottomAnchor).isActive = true
        typeField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        typeField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        subDescriptionField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subDescriptionField.topAnchor.constraint(equalTo: typeField.bottomAnchor).isActive = true
        subDescriptionField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        subDescriptionField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        contractNumberField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contractNumberField.topAnchor.constraint(equalTo: subDescriptionField.bottomAnchor).isActive = true
        contractNumberField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        contractNumberField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        addButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
