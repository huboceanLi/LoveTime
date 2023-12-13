//
//  LTInputView.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import UIKit
import SnapKit
import QMUIKit
import YYWebImage

class LTInputView: UIView {

    lazy var cionImageView: UIImageView = {
        let cionImageView = UIImageView(frame: .zero)
        cionImageView.backgroundColor = UIColor.purple
        return cionImageView
    }()
    
    lazy var textFiled: QMUITextField = {
        let textFiled = QMUITextField(frame: .zero)
        textFiled.font = UIFont.systemFont(ofSize: 15)
        textFiled.maximumTextLength = 10
        textFiled.placeholder = "备注..."
        return textFiled
    }()
    
    lazy var lines: UIView = {
        let lines1 = UIView(frame: .zero)
        lines1.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return lines1
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        addSubview(cionImageView)
        addSubview(textFiled)
        addSubview(lines)

        cionImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(22)
            make.left.equalTo(self.snp_left).offset(20)
        }
        
        textFiled.snp.makeConstraints { make in
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.snp_top).offset(5)
            make.bottom.equalTo(self.snp_bottom).offset(0)
            make.left.equalTo(self.cionImageView.snp_right).offset(12)
        }
        
        lines.snp.makeConstraints { make in
            make.right.equalTo(self.snp_right).offset(-20)
            make.bottom.equalTo(self.snp_bottom).offset(0)
            make.left.equalTo(self.snp_left).offset(20)
            make.height.equalTo(0.5)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
