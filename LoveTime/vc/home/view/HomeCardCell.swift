//
//  HomeCardCell.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/10/26.
//

import UIKit
import YYWebImage

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
        self.tagLab.text = model.address
        self.tilmeLab.text = LTHomeListLogic.share.convertTimestampToDateTime(timestamp: TimeInterval(model.changeTime/1000))
        
        if let img = UIImage.init(named: model.imageName) {
            self.headImageView.image = img
        }else {
            self.headImageView.yy_setImage(with: URL(fileURLWithPath: model.imageName))
        }
    }
}
