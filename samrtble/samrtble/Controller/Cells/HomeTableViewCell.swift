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
        
        
        CustomButton.customButtonWithShadow(button: schoolNameBtn)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
