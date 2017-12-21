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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbref = Database.database().reference(fromURL: "https://mobe03-dev.firebaseio.com/")
        
        view.addSubview(nameField)
        view.addSubview(contractNumberField)
        view.addSubview(dateField)
        view.addSubview(dateEndField)
        view.addSubview(subDescriptionField)
        view.addSubview(priceField)
        
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
            let subDescription = subDescriptionField.text
        else {
            print("Something")
            return
        }
        
        // Update to FDB
        let values = [
            "name": name,
            "date": date,
            "dateEnd": dateEnd,
            "price": price,
            "subDescription": subDescription
        ]
        
        dbref.child("subscription").child((Auth.auth().currentUser?.uid)!).childByAutoId().updateChildValues(values) { (error: Error?, ref ) in
            if error != nil {
                print(error as Any)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
            
            print("Subscription added to FDB")
        }
        
    }
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Subscription", for: .normal)
        button.backgroundColor = UIColor.blue
        
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
        tf.placeholder = "priceField"
        tf.textColor = UIColor.black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    @objc func setUpTextFields() {
        nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
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
        
        subDescriptionField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subDescriptionField.topAnchor.constraint(equalTo: priceField.bottomAnchor).isActive = true
        subDescriptionField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        subDescriptionField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        contractNumberField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contractNumberField.topAnchor.constraint(equalTo: subDescriptionField.bottomAnchor).isActive = true
        contractNumberField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        contractNumberField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: contractNumberField.bottomAnchor).isActive = true
        addButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

}
