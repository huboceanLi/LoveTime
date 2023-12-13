//
//  MYHeadView.swift
//  LoveTime
//
//  Created by Ocean 李 on 2023/12/10.
//

import UIKit
import SnapKit
import QMUIKit
import YYWebImage

class MYHeadView: UIView {

    var handleLoginCallback: (() -> Void)?

    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView(frame: .zero)
        headImageView.isUserInteractionEnabled = true
        headImageView.layer.cornerRadius = 45.0
        headImageView.layer.masksToBounds = true
        headImageView.layer.borderWidth = 4.0
        headImageView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        return headImageView
    }()
    
    lazy var viewTap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer.init()
        tap.addTarget(self, action: #selector(tapView(gestrue:)))
        return tap
    }()
    
    lazy var nameLab: UILabel = {
        let nameLab = UILabel(frame: .zero)
        nameLab.font = UIFont.systemFont(ofSize: 24)
        return nameLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        addSubview(headImageView)
        addSubview(nameLab)

        self.addGestureRecognizer(self.viewTap)
        
        headImageView.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(20)
            make.width.height.equalTo(90)
            make.top.equalTo(self.snp_top).offset(UIDevice.YH_Fringe_Height + 15)
//            make.centerX.equalToSuperview()
        }
        
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(self.headImageView.snp_right).offset(12)
            make.right.equalTo(self.snp_right).offset(-20)
            make.centerY.equalTo(self.headImageView.snp_centerY)
        }
    }

    func getModel(model:LTLoginModel) {
        self.headImageView.image = UIImage(named: model.imageName)
        self.nameLab.text = model.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapView(gestrue: UITapGestureRecognizer) {
        self.handleLoginCallback?()
    }
}
