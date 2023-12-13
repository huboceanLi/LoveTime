//
//  LTLoginView.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import UIKit
import SnapKit
import QMUIKit
import YYWebImage
import HYText

class LTLoginView: UIView {

    var handleLoginCallback: ((String,String) -> Void)?
    var handleTapTermCallback: (() -> Void)?

    lazy var cionImageView: UIImageView = {
        let cionImageView = UIImageView(frame: .zero)
        cionImageView.backgroundColor = UIColor.purple
        cionImageView.isUserInteractionEnabled = true
        cionImageView.layer.cornerRadius = 10.0
        cionImageView.layer.masksToBounds = true
        return cionImageView
    }()
    
    lazy var tipLab: UILabel = {
        let tipLab = UILabel(frame: .zero)
        tipLab.font = UIFont.lt_ZhenyanGBFont(ofSize: 26)
        tipLab.textAlignment = .center
        tipLab.text = "登录/注册"
        return tipLab
    }()
    
    private lazy var accountView: LTInputView = {
        let accountView = LTInputView()
        accountView.textFiled.maximumTextLength = 11
        accountView.textFiled.placeholder = "账号名..."
        return accountView
    }()
    
    private lazy var pwdView: LTInputView = {
        let pwdView = LTInputView()
        pwdView.textFiled.maximumTextLength = 12
        pwdView.textFiled.placeholder = "登录密码..."
        pwdView.textFiled.isSecureTextEntry = true
        return pwdView
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .custom)
        loginButton.setTitle("登录", for: .normal)
        loginButton.layer.cornerRadius = 6.0
        loginButton.layer.masksToBounds = true
        loginButton.backgroundColor = UIColor.green
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return loginButton
    }()
    
    private lazy var termLabel: YYLabel = {
        let termLabel = YYLabel()
        termLabel.numberOfLines = 0
        termLabel.textAlignment = .center
        termLabel.font = UIFont.systemFont(ofSize: 13)
        return termLabel
    }()
    
    @objc private func loginAction() {
        
        self.accountView.textFiled.resignFirstResponder()
        self.pwdView.textFiled.resignFirstResponder()

        if let str = self.accountView.textFiled.text, str.count == 11 {
            if let str1 = self.pwdView.textFiled.text, str1.count >= 6 {
                self.handleLoginCallback?(str,str1)
            }else {
                MYToast.onlyShowTextHUD("请输入6位及以上的密码")
                return
            }
        }else {
            MYToast.onlyShowTextHUD("请输入11位的账号")

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        addSubview(cionImageView)
        addSubview(tipLab)
        addSubview(accountView)
        addSubview(pwdView)
        addSubview(loginButton)
        self.addSubview(termLabel)

        cionImageView.snp.makeConstraints { make in
//            make.left.equalTo(self.snp_left).offset(20)
            make.width.height.equalTo(100)
            make.top.equalTo(self.snp_top).offset(40)
            make.centerX.equalToSuperview()
        }
        
        tipLab.snp.makeConstraints { make in
            make.top.equalTo(self.cionImageView.snp_bottom).offset(12)
            make.right.left.equalToSuperview()
        }
        
        accountView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.right.left.equalToSuperview()
            make.height.equalTo(50)
        }
        
        pwdView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
            make.right.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(self.snp_left).offset(20)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(self.pwdView.snp_bottom).offset(30)
            make.height.equalTo(50)
        }
        
        termLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp_bottom).offset(-UIDevice.YH_HomeIndicator_Height - 20)
            make.left.equalTo(self.snp_left).offset(30)
            make.right.equalTo(self.snp_right).offset(-30)
        }
        let termAttributeString = getTermAttributeString()
        self.termLabel.attributedText = termAttributeString
    }

    func getTermAttributeString() -> NSMutableAttributedString {
        var text = "注册即表示您阅读并同意"
        let term = "<隐私协议>"
        text = text + term
        let range = (text as NSString).range(of: term)
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.yy_alignment = .center
        attributeString.yy_font = UIFont.systemFont(ofSize: 13)
        attributeString.yy_color = UIColor.black
        attributeString.yy_setUnderlineStyle(.single, range: range)
        attributeString.yy_setUnderlineColor(UIColor.color4F80FF(), range: range)
        attributeString.yy_setTextHighlight(range, color: UIColor.color4F80FF(), backgroundColor: UIColor.clear) { [weak self] (_, _, _, _) in
            guard let _self = self else { return }
            
            _self.handleTapTermCallback?()
        }
        return attributeString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
