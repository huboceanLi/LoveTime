//
//  LTLoveEditView.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/12.
//

import UIKit
import SnapKit
import QMUIKit
import YYWebImage

class LTLoveEditView: UIView {

    var model: LTLoveListModel?
    var handleChooseImageCallback: (() -> Void)?

    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView(frame: .zero)
        headImageView.isUserInteractionEnabled = true
        headImageView.layer.cornerRadius = 8.0
        headImageView.layer.masksToBounds = true
        let tap = UITapGestureRecognizer.init()
        tap.addTarget(self, action: #selector(tapView(gestrue:)))
        headImageView.addGestureRecognizer(tap)
        return headImageView
    }()
    
    lazy var timeLab: UILabel = {
        let timeLab = UILabel(frame: .zero)
        timeLab.font = UIFont.systemFont(ofSize: 15)
        timeLab.backgroundColor = UIColor.green
        return timeLab
    }()
    
    lazy var nameTextFiled: QMUITextField = {
        let nameTextFiled = QMUITextField(frame: .zero)
        nameTextFiled.font = UIFont.systemFont(ofSize: 15)
        nameTextFiled.maximumTextLength = 12
        nameTextFiled.placeholder = "输入名称..."
        nameTextFiled.delegate = self
        return nameTextFiled
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
        addSubview(timeLab)
        addSubview(nameTextFiled)
        addSubview(lines1)
        addSubview(contentTextView)
        addSubview(lines2)

        headImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp_top).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(20)
            make.height.equalTo(20)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.headImageView.snp_bottom).offset(30)
        }
        
        nameTextFiled.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(20)
            make.height.equalTo(36)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.timeLab.snp_bottom).offset(30)
        }
        
        lines1.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(20)
            make.height.equalTo(0.5)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.nameTextFiled.snp_bottom).offset(0)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(20)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.lines1.snp_bottom).offset(20)
            make.height.equalTo(120)
        }
        
        lines2.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(20)
            make.height.equalTo(0.5)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.contentTextView.snp_bottom).offset(20)
        }
    }

    @objc private func tapView(gestrue: UITapGestureRecognizer) {
        self.handleChooseImageCallback?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getModel(model: LTLoveListModel) {
        self.model = model
        
        self.nameTextFiled.text = model.name
        self.timeLab.text = LTHomeListLogic.share.convertTimestampToDateTime(timestamp: TimeInterval(model.changeTime/1000))
        self.contentTextView.text = model.content
        if let img = UIImage.init(named: model.imageName) {
            self.headImageView.image = img
        }else {
            self.headImageView.yy_setImage(with: URL(fileURLWithPath: HYLocalPathManager.getImageFilePath(model.imageName)))
        }
    }
}

extension LTLoveEditView : QMUITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        if let s = textField.text {
            self.model?.name = s
        }

        return true
    }
}
