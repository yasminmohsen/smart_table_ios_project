//
//  TableCollectionViewCell.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 13/04/2021.
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    
    func customCell (text:String){
        
        self.label.lineBreakMode = .byWordWrapping
        self.label.numberOfLines = 0
        self.label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        self.label.textAlignment = .center
        self.label.textColor = UIColor.black
        self.label.text = text
        
    }
    
    
}
