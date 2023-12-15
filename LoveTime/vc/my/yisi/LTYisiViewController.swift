//
//  LTYisiViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import UIKit
import SnapKit
import QMUIKit

class LTYisiViewController: LTBaseViewController {

    lazy var contentTextView: QMUITextView = {
        let contentTextView = QMUITextView(frame: .zero)
        contentTextView.font = UIFont.systemFont(ofSize: 13)
        contentTextView.backgroundColor = UIColor.clear
        contentTextView.isEditable = false
        return contentTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusNaviBar.hideNaviBar = false
        self.defaultNaviTitleLabel.text = "隐私协议"
        self.cusNaviBar.backgroundColor = UIColor.clear
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        
        self.view.addSubview(contentTextView)
        contentTextView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(20)
            make.bottom.equalTo(self.view.snp_bottom).offset(-UIDevice.YH_HomeIndicator_Height)
        }
        
        if let filePath = Bundle.main.path(forResource: "shiyongxieyi", ofType: "txt") {
            let str = try? String(contentsOfFile: filePath, encoding: .utf8)           
            self.contentTextView.text = str
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
