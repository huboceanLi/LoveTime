//
//  HomeCardCell.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/10/26.
//

import UIKit

class HomeCardCell: LTCardCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 16.0
        self.layer.masksToBounds = true
    }

}
