//
//  CMYMenuTableViewCell.swift
//  CMYSideMenuDemo
//
//  Created by 程明勇 on 2018/7/12.
//  Copyright © 2018年 程明勇. All rights reserved.
//

import UIKit

class CMYMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//
        bgView.backgroundColor = selected ? UIColor.yellow : UIColor.clear
        titleLabel.textColor = selected ? UIColor.yellow : UIColor.white
    
    }

}
