//
//  HomeEditView.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/5.
//

import UIKit
import SnapKit
import QMUIKit

class HomeEditView: UIView {

    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView(frame: .zero)
        headImageView.backgroundColor = UIColor.green
        return headImageView
    }()
    
    lazy var nameImageView: UIImageView = {
        let nameImageView = UIImageView(frame: .zero)
        nameImageView.backgroundColor = UIColor.green
        return nameImageView
    }()
    
    lazy var nameTextFiled: QMUITextField = {
        let nameTextFiled = QMUITextField(frame: .zero)
        nameTextFiled.font = UIFont.systemFont(ofSize: 15)
        nameTextFiled.maximumTextLength = 12
        nameTextFiled.placeholder = "输入名称..."
        return nameTextFiled
    }()
    
    lazy var addressImageView: UIImageView = {
        let addressImageView = UIImageView(frame: .zero)
        addressImageView.backgroundColor = UIColor.green
        return addressImageView
    }()
   
    lazy var addressTextFiled: QMUITextField = {
        let addressTextFiled = QMUITextField(frame: .zero)
        addressTextFiled.font = UIFont.systemFont(ofSize: 15)
        addressTextFiled.maximumTextLength = 10
        addressTextFiled.placeholder = "备注..."
        return addressTextFiled
    }()
    
    lazy var timeImageView: UIImageView = {
        let timeImageView = UIImageView(frame: .zero)
        timeImageView.backgroundColor = UIColor.green
        return timeImageView
    }()
    
    lazy var timeLab: UILabel = {
        let timeLab = UILabel(frame: .zero)
        timeLab.font = UIFont.systemFont(ofSize: 15)
        return timeLab
    }()
    
    lazy var lines1: UIView = {
        let lines1 = UIView(frame: .zero)
        lines1.backgroundColor = UIColor.green
        return lines1
    }()
    
    lazy var contentTextView: QMUITextView = {
        let contentTextView = QMUITextView(frame: .zero)
        contentTextView.font = UIFont.systemFont(ofSize: 15)
        contentTextView.placeholder = "留下足迹..."
        return contentTextView
    }()
    
    lazy var lines2: UIView = {
        let lines2 = UIView(frame: .zero)
        lines2.backgroundColor = UIColor.green
        return lines2
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        
        addSubview(headImageView)
        addSubview(nameImageView)
        addSubview(nameTextFiled)
        addSubview(addressImageView)
        addSubview(addressTextFiled)
        addSubview(timeImageView)
        addSubview(timeLab)
        addSubview(lines1)
        addSubview(contentTextView)
        addSubview(lines2)

        headImageView.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(20)
            make.top.equalTo(self.snp_top).offset(20)
            make.width.equalTo(90)
            make.height.equalTo(120)

        }
        
        nameImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalTo(self.headImageView.snp_right).offset(12)
            make.top.equalTo(self.snp_top).offset(28)
        }
        
        nameTextFiled.snp.makeConstraints { make in
            make.left.equalTo(self.nameImageView.snp_right).offset(12)
            make.height.equalTo(24)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.snp_top).offset(28)
        }
        
        addressImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalTo(self.headImageView.snp_right).offset(12)
            make.top.equalTo(self.nameImageView.snp_bottom).offset(16)
        }
        
        addressTextFiled.snp.makeConstraints { make in
            make.left.equalTo(self.addressImageView.snp_right).offset(12)
            make.height.equalTo(24)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.nameImageView.snp_bottom).offset(16)
        }
        
        timeImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalTo(self.headImageView.snp_right).offset(12)
            make.top.equalTo(self.addressImageView.snp_bottom).offset(16)
        }
        
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(self.timeImageView.snp_right).offset(12)
            make.height.equalTo(24)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.timeImageView.snp_bottom).offset(16)
        }
        
        lines1.snp.makeConstraints { make in
            make.left.equalTo(self.headImageView.snp_left).offset(0)
            make.height.equalTo(0.5)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.headImageView.snp_bottom).offset(20)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.left.equalTo(self.headImageView.snp_left).offset(0)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.lines1.snp_bottom).offset(20)
            make.height.equalTo(120)
        }
        
        lines2.snp.makeConstraints { make in
            make.left.equalTo(self.headImageView.snp_left).offset(0)
            make.height.equalTo(0.5)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.contentTextView.snp_bottom).offset(20)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
