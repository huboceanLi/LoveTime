//
//  LTLoveListHeadView.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/7.
//

import UIKit
import SnapKit

class LTLoveListHeadView: UICollectionReusableView {

    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView(frame: .zero)
        headImageView.image = UIImage(named: "aiqingniao")
        return headImageView
    }()
    
    
    lazy var desLab: UILabel = {
        let desLab = UILabel(frame: .zero)
        desLab.font = UIFont.systemFont(ofSize: 16)
        return desLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        
        self.backgroundColor = UIColor.red
        
        addSubview(headImageView)
        addSubview(desLab)
        
        headImageView.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(15)
            make.width.height.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        desLab.snp.makeConstraints { make in
            make.left.equalTo(self.headImageView.snp_right).offset(10)
            make.centerY.equalToSuperview()
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
