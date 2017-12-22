//
//  SubscriptionCell.swift
//  mobe03
//
//  Created by Hadrien Lepoutre on 21/12/2017.
//  Copyright © 2017 Hadrien Lepoutre. All rights reserved.
//

import UIKit
import CoreGraphics

class SubscriptionCell: UICollectionViewCell {
    
    var sub: Subscription? {
        didSet {
            titleLabel.text = sub?.name
            subtitleLabel.text = sub?.dateEnd
            priceLabel.text = "\(sub?.price ?? "0") €"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    let cardView: UIView = {
        let color = CIColor.init(color: UIColor.init(red: 0, green: 0, blue: 0, alpha: 22/255))
        let view = UIView()
        view.layer.shadowOffset = CGSize(width: 2, height: 0)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.22
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let roundedCornerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(r: 151, g: 151, b: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let circleElement: UIImageView = {
        let image = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 14, height: 14))
        image.backgroundColor = UIColor.red
        image.layer.cornerRadius = image.frame.size.width/2
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    func setUpViews() {
        backgroundColor = UIColor.white
        
        // First Add subview
        addSubview(cardView)
        
        // Then Constraints for each views
        setUpCardView()
    }
    
    func setUpCardView() {
        addConstraintsWithFormat(format: "H:|-50-[view0]-50-|", views: cardView)
        addConstraintsWithFormat(format: "V:|-20-[view0]-20-|", views: cardView)
        
        cardView.addSubview(roundedCornerView)
        
        roundedCornerView.leftAnchor.constraint(equalTo: cardView.leftAnchor).isActive = true
        roundedCornerView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        roundedCornerView.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
        roundedCornerView.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
        
        roundedCornerView.addSubview(leftView)
        roundedCornerView.addSubview(rightView)
        
        roundedCornerView.addSubview(separatorView)
        
        separatorView.topAnchor.constraint(equalTo: roundedCornerView.topAnchor).isActive = true
        separatorView.rightAnchor.constraint(equalTo: leftView.rightAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.heightAnchor.constraint(equalTo: roundedCornerView.heightAnchor).isActive = true
        
        roundedCornerView.addSubview(colorView)
        
        colorView.leftAnchor.constraint(equalTo: roundedCornerView.leftAnchor).isActive = true
        colorView.topAnchor.constraint(equalTo: roundedCornerView.topAnchor).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 4).isActive = true
        colorView.heightAnchor.constraint(equalTo: roundedCornerView.heightAnchor).isActive = true
        
        setUpLeftView()
        setUpRightView()
    }
    
    func setUpLeftView() {
        leftView.leftAnchor.constraint(equalTo: roundedCornerView.leftAnchor).isActive = true
        leftView.topAnchor.constraint(equalTo: roundedCornerView.topAnchor).isActive = true
        leftView.widthAnchor.constraint(equalTo: roundedCornerView.widthAnchor, multiplier: 2/3).isActive = true
        leftView.heightAnchor.constraint(equalTo: roundedCornerView.heightAnchor).isActive = true
        
        leftView.addSubview(titleLabel)
        leftView.addSubview(subtitleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: leftView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: leftView.centerYAnchor, constant: -13).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: leftView.widthAnchor, constant: -24).isActive = true
        
        subtitleLabel.centerXAnchor.constraint(equalTo: leftView.centerXAnchor).isActive = true
        subtitleLabel.centerYAnchor.constraint(equalTo: leftView.centerYAnchor, constant: 13).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: leftView.widthAnchor, constant: -24).isActive = true
    }
    
    func setUpRightView() {
        rightView.leftAnchor.constraint(equalTo: leftView.rightAnchor).isActive = true
        rightView.topAnchor.constraint(equalTo: roundedCornerView.topAnchor).isActive = true
        rightView.widthAnchor.constraint(equalTo: roundedCornerView.widthAnchor, multiplier: 1/3).isActive = true
        rightView.heightAnchor.constraint(equalTo: roundedCornerView.heightAnchor).isActive = true
        
        rightView.addSubview(priceLabel)
        
        priceLabel.centerXAnchor.constraint(equalTo: rightView.centerXAnchor).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: rightView.centerYAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalTo: rightView.widthAnchor, constant: -24).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 24)
        
        rightView.addSubview(circleElement)
        
        circleElement.centerXAnchor.constraint(equalTo: rightView.rightAnchor, constant: -14).isActive = true
        circleElement.centerYAnchor.constraint(equalTo: rightView.topAnchor, constant: 14).isActive = true
        circleElement.heightAnchor.constraint(equalToConstant: 14).isActive = true
        circleElement.widthAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
