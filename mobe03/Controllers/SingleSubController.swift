//
//  SingleSubController.swift
//  mobe03
//
//  Created by Hadrien Lepoutre on 21/12/2017.
//  Copyright © 2017 Hadrien Lepoutre. All rights reserved.
//

import UIKit

class SingleSubController: UIViewController, UITextFieldDelegate {
    
    var sub: Subscription? {
        didSet {
            priceLabel.text = "\(sub?.price ?? "0") € "
            
//            switch sub?.type as? String {
//            case "Annuel"?:
//                priceDetailsLabel.text = "/An"
//            case "Mensuel"?:
//                priceDetailsLabel.text = "/Mois"
//            case "Essai Gratuit"?:
//                priceDetailsLabel.text = "Essai gratuit"
//            default:
//                priceDetailsLabel.text = ""
//            }
            
            priceDetailsLabel.text = "/Mois"
            
            dateEndLabel.text = sub?.dateEnd
            
            contractLabel.text = sub?.contractNumber
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = sub?.name
        
        setUpViews()
    }
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.textAlignment = NSTextAlignment.right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateEndTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(r: 105, g: 105, b: 105)
        label.text = "Fin de l'abonnement"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateEndLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contractTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(r: 105, g: 105, b: 105)
        label.text = "Numéro de contrat"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contractLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let endContractButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("End Contract", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(r: 120, g: 159, b: 227)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let renewContractButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Renew", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(r: 120, g: 159, b: 227)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setUpViews() {
        view.addSubview(priceLabel)
        priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        priceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        priceLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2, constant: -12).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 48)
        
        view.addSubview(priceDetailsLabel)
        priceDetailsLabel.leftAnchor.constraint(equalTo: priceLabel.rightAnchor).isActive = true
        priceDetailsLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: -4).isActive = true
        priceDetailsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2, constant: -12).isActive = true
        priceDetailsLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        view.addSubview(dateEndTitle)
        dateEndTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        dateEndTitle.topAnchor.constraint(equalTo: priceDetailsLabel.bottomAnchor, constant: 40).isActive = true
        dateEndTitle.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -140).isActive = true
        dateEndTitle.heightAnchor.constraint(equalToConstant: 14)
        
        view.addSubview(dateEndLabel)
        dateEndLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        dateEndLabel.topAnchor.constraint(equalTo: dateEndTitle.bottomAnchor, constant: 4).isActive = true
        dateEndLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -140).isActive = true
        dateEndLabel.heightAnchor.constraint(equalToConstant: 14)
        
        view.addSubview(contractTitle)
        contractTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        contractTitle.topAnchor.constraint(equalTo: dateEndLabel.bottomAnchor, constant: 14).isActive = true
        contractTitle.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -140).isActive = true
        contractTitle.heightAnchor.constraint(equalToConstant: 14)
        
        view.addSubview(contractLabel)
        contractLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        contractLabel.topAnchor.constraint(equalTo: contractTitle.bottomAnchor, constant: 4).isActive = true
        contractLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -140).isActive = true
        contractLabel.heightAnchor.constraint(equalToConstant: 14)
        
        view.addSubview(endContractButton)
        endContractButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18).isActive = true
        endContractButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        endContractButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        endContractButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2, constant: -24).isActive = true
        
        view.addSubview(renewContractButton)
        renewContractButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18).isActive = true
        renewContractButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        renewContractButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        renewContractButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2, constant: -24).isActive = true
    }
    
}
