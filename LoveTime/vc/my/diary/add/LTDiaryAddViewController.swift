//
//  LTDiaryAddViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import UIKit
import SnapKit
import MBProgressHUD

class LTDiaryAddViewController: LTBaseViewController {

    var handleDiaryCallback: (() -> Void)?

    private lazy var diaryEditView: LTDiaryEditView = {
        let diaryEditView = LTDiaryEditView()
        return diaryEditView
    }()
    
    private lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        moreButton.setTitle("完成", for: .normal)
        moreButton.setTitleColor(UIColor.black, for: .normal)
        moreButton.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return moreButton
    }()
    
    private lazy var rightItems: [Any] = {
        var rightSpaceItem = YHCusNavigationSpaceItem()
        rightSpaceItem.space = 10.0
        
        var rightAddItem = YHCusNavigationBarItem()
        rightAddItem.width = 40.0
        rightAddItem.view = self.moreButton
        
        return [rightAddItem, rightSpaceItem]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusNaviBar.hideNaviBar = false
        self.defaultNaviTitleLabel.text = "添加日记"
        self.cusNaviBar.rightItems = self.rightItems
        self.cusNaviBar.backgroundColor = UIColor.clear
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        
        
        self.view.addSubview(diaryEditView)
        
        diaryEditView.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(0)
        }
    }
    
    @objc private func moreAction() {
        self.view.endEditing(true)
        if let str = self.diaryEditView.nameTextFiled.text, str.count > 0 {
            if let str1 = self.diaryEditView.contentTextView.text, str1.count > 0 {
                MBProgressHUD.showAdded(to: self.view, animated: true)

                Task {
                    await LTDiaryLogic.share.insertList(name:str, content:str1)
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.handleDiaryCallback?()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }else {
                MYToast.onlyShowTextHUD("请输入日记内容!")
                return
            }
        }else {
            MYToast.onlyShowTextHUD("请输入标题!")
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
