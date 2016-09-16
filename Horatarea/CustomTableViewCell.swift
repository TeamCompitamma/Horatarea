//
//  CustomTableViewCell.swift
//  Horatarea
//
//  Created by 松本博希 on 2016/09/15.
//  Copyright © 2016年 Hiroki MATSUMOTO. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var categoryImage : UIImageView!
    @IBOutlet var todolabel : UILabel!
    @IBOutlet var datelabel : UILabel!
    @IBOutlet var workvalue : UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
