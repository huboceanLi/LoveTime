//
//  LTLoveListCell.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/7.
//

import UIKit
import SnapKit
import YYWebImage

class LTLoveListCell: UICollectionViewCell {

    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView(frame: .zero)
        headImageView.backgroundColor = UIColor.green
        headImageView.layer.cornerRadius = loveListItemWidth / 2
        headImageView.layer.masksToBounds = true
        return headImageView
    }()
    
    
    lazy var desLab: UILabel = {
        let desLab = UILabel(frame: .zero)
        desLab.font = UIFont.systemFont(ofSize: 12)
        desLab.text = "情侣必备的100件事"
        desLab.numberOfLines = 2
        desLab.textAlignment = .center
        return desLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        addSubview(headImageView)
        addSubview(desLab)
        
        headImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp_top).offset(0)
            make.width.height.equalTo(loveListItemWidth)
        }
        
        desLab.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.headImageView.snp_bottom).offset(8)
        }
    }

    func getModel(model: LTLoveListModel)  {
        
        if let img = UIImage.init(named: model.imageName) {
            self.headImageView.image = img
        }else {
            self.headImageView.yy_setImage(with: URL(fileURLWithPath: HYLocalPathManager.getImageFilePath(model.imageName)))
        }
        self.desLab.text = model.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
