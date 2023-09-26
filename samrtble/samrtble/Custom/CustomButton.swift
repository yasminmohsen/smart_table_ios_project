//
//  CustomButton.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 22/03/2021.
//

import Foundation
import UIKit
class CustomButton {
    
    static func customViewWithShadow ( view:UIView) {
        view.layer.cornerRadius = 12
        view.clipsToBounds = false
        view.layer.shadowColor =  UIColor(red: 0, green: 0, blue: 0 ,alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height:3.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 3.0
        
    }
    
    static func customBarButton (btnBack :UIButton , title:String){
        
        btnBack.setTitle("\(title)", for: .normal)
        btnBack.setTitleColor(UIColor(red: 180/255, green: 147/255, blue: 108/255, alpha: 1.0), for: .normal)
        btnBack.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        btnBack.layer.shadowOffset = CGSize(width: 0.0, height:2.0)
        btnBack.layer.shadowColor = UIColor(red: 180/255, green: 147/255, blue: 108/255, alpha: 1.0).cgColor
        btnBack.layer.shadowOpacity = 1.0
        btnBack.layer.shadowRadius = 10.0
        btnBack.layer.masksToBounds = false
        btnBack.layer.borderWidth = 0.2
        btnBack.layer.borderColor = UIColor(red: 180/255, green: 147/255, blue: 108/255, alpha: 1.0).cgColor
        
    }
    
}


extension UIView {
    
    func applyShadowWithCornerRadius(color:UIColor, opacity:Float, radius: CGFloat, edge:AIEdge, shadowSpace:CGFloat)    {
        
        var sizeOffset:CGSize = CGSize.zero
        switch edge {
        case .Top:
            sizeOffset = CGSize(width: 0, height: -shadowSpace)
        case .Left:
            sizeOffset = CGSize(width: -shadowSpace, height: 0)
        case .Bottom:
            sizeOffset = CGSize(width: 0, height: shadowSpace)
        case .Right:
            sizeOffset = CGSize(width: shadowSpace, height: 0)
        case .Top_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace)
        case .Top_Right:
            sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace)
        case .Bottom_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace)
        case .Bottom_Right:
            sizeOffset = CGSize(width: shadowSpace, height: shadowSpace)
        case .All:
            sizeOffset = CGSize(width: 0, height: 0)
        case .None:
            sizeOffset = CGSize.zero
        }
        
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true;
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = sizeOffset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
    }
}

enum AIEdge:Int {
    case
    Top,
    Left,
    Bottom,
    Right,
    Top_Left,
    Top_Right,
    Bottom_Left,
    Bottom_Right,
    All,
    None
}
