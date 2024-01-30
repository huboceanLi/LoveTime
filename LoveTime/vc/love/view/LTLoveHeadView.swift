//
//  LTLoveHeadView.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/7.
//

import UIKit
import SnapKit

class LTLoveHeadView: UIView {

    lazy var titleLab: UILabel = {
        let titleLab = UILabel(frame: .zero)
        titleLab.font = UIFont.lt_ZhenyanGBFont(ofSize: 30)
        titleLab.text = "恋爱清单"
        return titleLab
    }()
    
    lazy var desLab: UILabel = {
        let desLab = UILabel(frame: .zero)
        desLab.font = UIFont.lt_ZhenyanGBFont(ofSize: 15)
        desLab.text = "情侣必备的100件事"
        return desLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        addSubview(titleLab)
        addSubview(desLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(15)
            make.top.equalTo(self.snp_top).offset(UIDevice.YH_Fringe_Height + 15)
        }
        
        desLab.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(15)
            make.top.equalTo(self.titleLab.snp_bottom).offset(8)
            make.bottom.equalTo(self.snp_bottom).offset(-15)
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
