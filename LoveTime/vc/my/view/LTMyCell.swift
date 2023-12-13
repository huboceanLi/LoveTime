//
//  LTMyCell.swift
//  LoveTime
//
//  Created by Ocean 李 on 2023/12/10.
//

import UIKit

class LTMyCell: UITableViewCell {

    @IBOutlet weak var lines: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lines.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
