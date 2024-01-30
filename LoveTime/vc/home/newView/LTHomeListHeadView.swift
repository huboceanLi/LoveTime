//
//  LTHomeListHeadView.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/27.
//

import UIKit
import SnapKit

class LTHomeListHeadView: UICollectionReusableView {
        
    lazy var titleLab: UILabel = {
        let titleLab = UILabel(frame: .zero)
        titleLab.font = UIFont.lt_ZhenyanGBFont(ofSize: 20)
        return titleLab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        self.backgroundColor = UIColor.clear
        addSubview(titleLab)

        titleLab.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(15)
            make.centerY.equalToSuperview()
//            make.top.equalTo(self.snp_top).offset(UIDevice.YH_Fringe_Height + 15)
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
