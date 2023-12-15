//
//  LTClockViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import UIKit
import SnapKit

class LTClockViewController: LTBaseViewController {

    private lazy var clockView: JHTheClockView = {
        let clockView = JHTheClockView()
        return clockView
    }()
    
    deinit {
        print("IMChatView deinit!!!")
        self.clockView.removeLayer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusNaviBar.hideNaviBar = false
        self.defaultNaviTitleLabel.text = "情侣时钟"
//        self.cusNaviBar.rightItems = self.rightItems
        self.cusNaviBar.backgroundColor = UIColor.clear
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        
        self.view.addSubview(clockView)
        clockView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(UIDevice.YH_Width / 2.0)
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(30)
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
