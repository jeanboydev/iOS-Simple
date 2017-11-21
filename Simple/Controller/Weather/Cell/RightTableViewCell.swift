//
//  RightTableViewCell.swift
//  Simple
//
//  Created by Next on 2017/11/6.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class RightTableViewCell: UITableViewCell {

    @IBOutlet weak var indicatorImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var deleteImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
//        self.deleteImage.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
