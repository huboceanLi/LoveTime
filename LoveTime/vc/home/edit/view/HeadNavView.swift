//
//  HeadNavView.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/5.
//

import UIKit
import SnapKit

class HeadNavView: UIView {

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
        
    }
    
    @objc private func completeAction() {
        
    }
    
    func setUpUI() {
        self.backgroundColor = UIColor.green
        addSubview(closeButton)
        addSubview(completeButton)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
