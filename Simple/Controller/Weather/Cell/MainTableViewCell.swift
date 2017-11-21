//
//  MainTableViewCell.swift
//  Simple
//
//  Created by Next on 2017/11/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none//取消选中效果
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
