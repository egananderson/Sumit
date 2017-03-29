//
//  SumitTableViewCell.swift
//  Sumit
//
//  Created by Egan Anderson on 3/29/17.
//  Copyright © 2017 via cole. All rights reserved.
//

import UIKit

class SumitTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var badgeImageView: UIImageView!
    @IBOutlet var numberLabel: UILabel!
    var image360: UIImage!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func vrButtonPressed(_ sender: UIButton) {
        let cardboardVC = CardboardVC()
        cardboardVC.image360 = image360
        cardboardVC.modalTransitionStyle = .crossDissolve
        let userController = UserController.sharedInstance
        userController.sumitsVC!.present(cardboardVC, animated: true, completion: nil)
    }
}
