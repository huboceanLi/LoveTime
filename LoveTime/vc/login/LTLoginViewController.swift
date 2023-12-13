//
//  LTLoginViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift
import MBProgressHUD

class LTLoginViewController: LTBaseViewController {

    private lazy var loginView: LTLoginView = {
        let loginView = LTLoginView()
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusNaviBar.hideNaviBar = false
        self.cusNaviBar.backgroundColor = UIColor.clear
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        
        self.view.addSubview(loginView)
        
        loginView.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(0)
        }
        
        loginView.handleLoginCallback = { [weak self] (phone, pwd) in
                
            guard let self = self else {
                return
            }
            MBProgressHUD.showAdded(to: self.view, animated: true)
            Task {
                await LTLoginLogic.share.insertList(phone: phone, pwd: pwd)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "LT_LOGIN"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
            
        }
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
