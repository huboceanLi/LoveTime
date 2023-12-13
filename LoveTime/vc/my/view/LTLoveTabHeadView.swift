//
//  LTLoveTabHeadView.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import UIKit
import SnapKit

class LTLoveTabHeadView: UIView {

    lazy var nameLab: UILabel = {
        let nameLab = UILabel(frame: .zero)
        nameLab.font = UIFont.lt_ZhenyanGBFont(ofSize: 16)
        return nameLab
    }()
    
    lazy var lines: UIView = {
        let lines1 = UIView(frame: .zero)
        lines1.backgroundColor = UIColor.red
        return lines1
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        addSubview(lines)
        addSubview(nameLab)

        lines.snp.makeConstraints { make in
            make.height.equalTo(12)
            make.width.equalTo(4)
            make.left.equalTo(self.snp_left).offset(20)
            make.centerY.equalToSuperview()
        }
        
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(self.lines.snp_right).offset(12)
            make.centerY.equalToSuperview()
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
