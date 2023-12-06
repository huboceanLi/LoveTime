//
//  HeadNavView.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/5.
//

import UIKit
import SnapKit

class HeadNavView: UIView {

    var handleCloseCallback: (() -> Void)?
    var handleCompleteCallback: (() -> Void)?

    private lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "chat_list_more"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var completeButton: UIButton = {
        let completeButton = UIButton(type: .custom)
        completeButton.setImage(UIImage(named: "chat_list_more"), for: .normal)
        completeButton.addTarget(self, action: #selector(completeAction), for: .touchUpInside)
        return completeButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    @objc private func closeAction() {
        self.handleCloseCallback?()
    }
    
    @objc private func completeAction() {
        self.handleCompleteCallback?()
    }
    
    func setUpUI() {
        self.backgroundColor = UIColor.green
        addSubview(closeButton)
        addSubview(completeButton)

        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.left.equalTo(self.snp_left).offset(10)
            make.bottom.equalTo(self.snp_bottom).offset(-5)
        }
        
        completeButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(self.snp_right).offset(-10)
            make.bottom.equalTo(self.snp_bottom).offset(-5)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
