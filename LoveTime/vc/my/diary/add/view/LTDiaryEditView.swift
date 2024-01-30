//
//  LTDiaryEditView.swift
//  LoveTime
//
//  Created by Ocean 李 on 2023/12/13.
//

import UIKit
import SnapKit
import QMUIKit

class LTDiaryEditView: UIView {

    lazy var nameTextFiled: QMUITextField = {
        let nameTextFiled = QMUITextField(frame: .zero)
        nameTextFiled.font = UIFont.systemFont(ofSize: 15)
        nameTextFiled.maximumTextLength = 20
        nameTextFiled.placeholder = "输入名称..."
//        nameTextFiled.delegate = self
        nameTextFiled.textAlignment = .center
        return nameTextFiled
    }()
    
    lazy var lines1: UIView = {
        let lines1 = UIView(frame: .zero)
        lines1.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        return lines1
    }()
    
    lazy var contentTextView: QMUITextView = {
        let contentTextView = QMUITextView(frame: .zero)
        contentTextView.font = UIFont.systemFont(ofSize: 15)
        contentTextView.placeholder = "留下足迹..."
        contentTextView.backgroundColor = UIColor.clear
        return contentTextView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        addSubview(nameTextFiled)
        addSubview(lines1)
        addSubview(contentTextView)

        nameTextFiled.snp.makeConstraints { make in
            make.top.equalTo(self.snp_top).offset(20)
            make.left.equalTo(self.snp_left).offset(20)
            make.right.equalTo(self.snp_right).offset(-20)
            make.height.equalTo(32)
        }
        
        lines1.snp.makeConstraints { make in
            make.top.equalTo(self.nameTextFiled.snp_bottom).offset(10)
            make.left.equalTo(self.snp_left).offset(20)
            make.right.equalTo(self.snp_right).offset(-20)
            make.height.equalTo(0.5)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(self.lines1.snp_bottom).offset(20)
            make.left.equalTo(self.snp_left).offset(20)
            make.right.equalTo(self.snp_right).offset(-20)
            make.height.equalTo(300)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
