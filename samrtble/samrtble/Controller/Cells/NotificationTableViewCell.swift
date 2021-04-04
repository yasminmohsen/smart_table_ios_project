//
//  NotificationTableViewCell.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 03/04/2021.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var viewCell: UIView!
    
    @IBOutlet weak var schoolLabel: UILabel!
 
    
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func languageCustomUi(cell:NotificationTableViewCell) {
        
        let lang = LanguageOperation.checkLanguage()
        switch lang {
        case .arabic:
            cell.detailsLabel?.textAlignment = .right
            cell.schoolLabel?.textAlignment = .right
       
        default:
            cell.schoolLabel?.textAlignment = .left
            cell.detailsLabel?.textAlignment = .left
        }
        
        
       
    }

}
