//
//  HomeTableViewCell.swift
//  smartble
//
//  Created by Yasmin Mohsen on 18/03/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var schoolNameBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        schoolNameBtn.layer.borderWidth = 1.0
        schoolNameBtn.layer.borderColor = UIColor.black.cgColor
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
