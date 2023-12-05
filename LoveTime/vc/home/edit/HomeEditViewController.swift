//
//  HomeEditViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/5.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift

class HomeEditViewController: LTBaseViewController {

    var model: LTHomeListModel?
    
    lazy var homeEditView: HomeEditView = {
        let homeEditView = HomeEditView(frame: .zero)
        return homeEditView
    }()
    
    lazy var headNavView: HeadNavView = {
        let headNavView = HeadNavView(frame: .zero)
        return headNavView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpUI()
    }
    
    func setUpUI() {
        self.view.addSubview(headNavView)

        headNavView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(56)
        }
        
        self.view.backgroundColor = .red
//        self.cusNaviBar.hideNaviBar = false
//        self.cusNaviBar.backgroundColor = UIColor.green
//        self.cusNaviBar.YH_Height = 50
//        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        
        IQKeyboardManager.shared.enableAutoToolbar = true

        self.view.addSubview(homeEditView)

        homeEditView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.headNavView.snp_bottom).offset(0)
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
