//
//  CatFactsTableViewCell.swift
//  CatFacts
//
//  Created by  William on 1/21/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import UIKit

class CatFactsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textCommentLabel: UILabel!
    
    var item: Comment? {
        didSet {
            let firstName = item?.firstName
            let lastName = item?.lastName
            if (firstName == nil && lastName == nil) {
                nameLabel.text = "Anonymous user"
            } else {
              nameLabel.text = "\(firstName ?? "") \(lastName ?? "")"
            }
            
            textCommentLabel.text = item?.text
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
