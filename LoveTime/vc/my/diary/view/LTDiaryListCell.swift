//
//  LTDiaryListCell.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/14.
//

import UIKit

class LTDiaryListCell: UITableViewCell {

    @IBOutlet weak var line: UIView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.content.numberOfLines = 2;
        self.content.font = UIFont.systemFont(ofSize: 14)
        self.content.textColor = UIColor.color0D1324().withAlphaComponent(0.6)
        self.name.textColor = UIColor.color0D1324()
        self.name.font = UIFont.boldSystemFont(ofSize: 17)
        self.timeLab.font = UIFont.systemFont(ofSize: 14)
        self.timeLab.textColor = UIColor.color0D1324().withAlphaComponent(0.6)
        
        self.line.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
