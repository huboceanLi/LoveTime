//
//  LTHomeListCell.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/27.
//

import UIKit
import YYWebImage

class LTHomeListCell: UICollectionViewCell {

    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headImageView.layer.cornerRadius = 10.0
        headImageView.layer.masksToBounds = true
        headImageView.contentMode = .scaleAspectFill
        
        name.font = UIFont.systemFont(ofSize: 12)
        timeLab.font = UIFont.systemFont(ofSize: 11)
        timeLab.textColor = UIColor.white
    }

    func getModel(model: LTHomeListModel) {
        
        self.name.text = model.name
//        self.contentLab.text = model.content
//        self.tagLab.text = model.address
        self.timeLab.text = LTHomeListLogic.share.convertTimestampToDateTime(timestamp: TimeInterval(model.changeTime/1000))
        
        if let img = UIImage.init(named: model.imageName) {
            self.headImageView.image = img
        }else {
            self.headImageView.yy_setImage(with: URL(fileURLWithPath: HYLocalPathManager.getImageFilePath(model.imageName)))
        }
    }
}
