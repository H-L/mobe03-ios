//
//  LoginController.swift
//  mobe03
//
//  Created by Hadrien Lepoutre on 19/12/2017.
//  Copyright © 2017 Hadrien Lepoutre. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    // Segmented Controls
    let loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        print(title!)
        registerButton.setTitle(title, for: .normal)
    }
    
    // Fields Container
    let inputsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
        // Fields
        let mailTextField: UITextField = {
            let tf = UITextField()
            tf.placeholder = "Email"
            tf.keyboardType = .emailAddress
            tf.autocapitalizationType = UITextAutocapitalizationType.none
            tf.translatesAutoresizingMaskIntoConstraints = false
            return tf
        }()
    
        let passwordTextField: UITextField = {
            let tf = UITextField()
            tf.placeholder = "Password"
            tf.isSecureTextEntry = true
            tf.translatesAutoresizingMaskIntoConstraints = false
            return tf
        }()
    
        // Separators
        let mailSeparator: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    // Register Button
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(r: 50, g: 100, b: 70)
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    @objc func handleRegister() {
        guard let email = mailTextField.text, let password = passwordTextField.text else {
            print("Not valid data")
            return
        }
        
        // Create a new User
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error) in
            if error != nil {
                print(error ?? "Error in handleRegister/createUser")
                self.showAlert(message: error!.localizedDescription.description)
                return
            }
            else {
                self.dismiss(animated: true, completion: nil)
                print("New User registered")
            }
        }
    }
    
    @objc func handleLogin() {
        guard let email = mailTextField.text, let password = passwordTextField.text else {
            print("Not valid data")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.showAlert(message: error!.localizedDescription.description)
                return
            }
            else {
                self.dismiss(animated: true, completion: nil)
                print("User logged in")
            }
        })
    }
    
    @objc func showAlert(message: String) {
        let alert = UIAlertController.init(title: "Error at Login / Register", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change view BG
        view.backgroundColor = UIColor.lightGray
        
        view.addSubview(inputsView)
        view.addSubview(registerButton)
        view.addSubview(loginRegisterSegmentedControl)

        setUpInputsView()
        setUpRegisterButton()
        setUpLoginRegisterSegmentedControl()
    }
    
    // Status bar to white
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    func setUpLoginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    // Set up Fields Container View and its Subviews
    func setUpInputsView() {
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // Subviews
        inputsView.addSubview(mailTextField)
        inputsView.addSubview(mailSeparator)
        inputsView.addSubview(passwordTextField)
        
        // Subviews Settings
        mailTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        mailTextField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        mailTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        mailTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2).isActive = true
        
        mailSeparator.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        mailSeparator.topAnchor.constraint(equalTo: mailTextField.bottomAnchor).isActive = true
        mailSeparator.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        mailSeparator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: mailSeparator.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    // Set up Register Button
    func setUpRegisterButton() {
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
