//
//  HomeCardCell.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/10/26.
//

import UIKit

class HomeCardCell: LTCardCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var tilmeLab: UILabel!
    @IBOutlet weak var tagLab: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 16.0
        self.layer.masksToBounds = true
    }

    func getModel(model: LTHomeListModel) {
        
        self.titleLab.text = model.name
        self.contentLab.text = model.content
        self.tagLab.text = model.typeName
        
    }
}
