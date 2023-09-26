//
//  SpreadViewCells.swift
//  smartble
//
//  Created by Yasmin Mohsen on 18/03/2021.
//

import Foundation
import UIKit
import SpreadsheetView

class TableCell: Cell {
    
    let label = UILabel()
    var color: UIColor = .clear {
        didSet {
            backgroundView?.backgroundColor = color
        }
    }
    
    override var frame: CGRect {
        didSet {
            label.frame = bounds.insetBy(dx: 0, dy: 0)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundView = UIView()
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        backgroundView!.layer.backgroundColor = UIColor.white.cgColor
        label.textColor = UIColor.black
        backgroundView?.layer.cornerRadius = 12
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


