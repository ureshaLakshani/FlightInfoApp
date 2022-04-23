//
//  CustomUIView.swift
//  FlightInfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import UIKit

@IBDesignable class CustomUIView: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // corner radius top left right
    @IBInspectable var cornerRTLR: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRTLR
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    
    // corner radius bottom left right
   @IBInspectable var cornerRBLR: CGFloat = 0.0 {
       didSet {
           layer.cornerRadius = cornerRTLR
           layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
       }
   }
    
    // corner radius Bottom left
    @IBInspectable var cornerRBL: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRBL
            layer.maskedCorners = [.layerMinXMaxYCorner]
        }
    }
    
    // corner radius Top Right
    @IBInspectable var cornerRTR: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRTR
            layer.maskedCorners = [.layerMinXMinYCorner]
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
    }
}
