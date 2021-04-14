//
//  CustomDesignView.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 03/04/2021.
//

import Foundation
import UIKit
import SideMenu
import SpreadsheetView
class CustomDesignView {
    
    static func customMenuShadowView (_ menu :SideMenuNavigationController){
        
        
//                menu.view.layer.shadowColor =  UIColor(red: 0, green: 0, blue: 0 ,alpha: 0.5).cgColor
//                menu.view.layer.shadowOffset = CGSize(width: 3.0, height:3.0)
//                menu.view.layer.shadowOpacity = 1.0
//                menu.view.layer.shadowRadius = 3.0
//                menu.view.layer.borderWidth = 0.2
//                menu.view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0 ,alpha: 0.16).cgColor
    }
    
    
    
    static func customViewWithShadow ( view:UIView){
        
       
       view.layer.cornerRadius = 12
        view.clipsToBounds = false
     
      view.layer.shadowColor =  UIColor(red: 0, green: 0, blue: 0 ,alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height:3.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 3.0
 
        
    }
    
    
    static func customTextView ( view:UIView){
        
       
       view.layer.cornerRadius = 12
        view.clipsToBounds = true
     
        view.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        view.layer.borderWidth = 0.2
        
    }
    
    
    
    static func customSpreadSheetView(_ i : SpreadsheetView){
        
        i.register(TableCell.self, forCellWithReuseIdentifier: String(describing: TableCell.self))
    
        i.bounces = false
        i.isScrollEnabled = false
        i.layer.masksToBounds = false
        i.backgroundView?.layer.cornerRadius = 12
        i.clipsToBounds = true
        i.layer.cornerRadius = 12
        i.gridStyle = .none
        
        
        
    }
    
    static func customPageController(_ pageControl :UIPageControl){
        
        pageControl.currentPageIndicatorTintColor = Colors.getColor(type: .customorange)[0]
      
 
        pageControl.pageIndicatorTintColor = Colors.getColor(type: .gradientWhite)[3]
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)


         

        }
    }
    
    
   static func customColoredSheet(_ spreedSheet:SpreadsheetView ,_ cell : TableCell  )  {
        spreedSheet.gridStyle = .solid(width:2, color: Colors.getColor(type: .customBej)[0])
        spreedSheet.layer.backgroundColor = Colors.getColor(type: .customBej)[0].cgColor
        cell.label.layer.backgroundColor = Colors.getColor(type: .customBej)[0].cgColor
        
    }
    
    
    
}
