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
    
    lazy var nameLab: UILabel = {
        let nameLab = UILabel(frame: .zero)
        nameLab.numberOfLines = 0
        nameLab.textAlignment = .center
        nameLab.font = UIFont.lt_QisimomoFont(ofSize: 22)
        return nameLab
    }()
    
    
    lazy var timeLab: UILabel = {
        let timeLab = UILabel(frame: .zero)
        timeLab.textAlignment = .center
        timeLab.font = UIFont.lt_ZhenyanGBFont(ofSize: 22)
        timeLab.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init()
        tap.addTarget(self, action: #selector(timeView(gestrue:)))
        timeLab.addGestureRecognizer(tap)
        return timeLab
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
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(50)
        }
        
        self.view.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalTo(self.view.snp_left).offset(30)
            make.right.equalTo(self.view.snp_right).offset(-30)
        }
        
        let str = HYLocalPathManager.randomGeyan()
        self.nameLab.text = str
        self.nameLab.alpha = 0.0

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            UIView.animate(withDuration: 0.5) {
                self.nameLab.alpha = 1.0
            }
        }
        
        
        self.view.addSubview(timeLab)
        timeLab.snp.makeConstraints { make in
            make.top.equalTo(self.nameLab.snp_bottom).offset(60)
            make.left.equalTo(self.view.snp_left).offset(30)
            make.right.equalTo(self.view.snp_right).offset(-30)
        }
        
        if let timeInt: Int = UserDefaults.standard.object(forKey: "GEYANTIME") as? Int {
            let nt = LTHomeListLogic.share.getNowTime()
            let lt: Int = nt - timeInt
            
            if lt > 0 {

                let dt: Int = lt / 1000 / 60 / 60 / 24
                
                self.timeLab.text = "我们已经在在一起" + String(dt) + "天了"

            }
        }else {
            self.timeLab.text = "-请选择恋爱开始的时间-"
        }
    }
    
    @objc private func timeView(gestrue: UITapGestureRecognizer) {
        
        let pickView = TQDatePickerView(type: .KDatePickerDate)
        pickView.sucessReturnB = {[weak self] (date: String) in
            
            guard let self = self else {
                return
            }
            let t = HYLocalPathManager.getTimeStr(with: date)
            
            
            let nt = LTHomeListLogic.share.getNowTime()
            
            let lt: Int = nt - (Int(t) ?? 0)
            
            if lt > 0 {
                
                
                UserDefaults.standard.setValue(Int(t), forKey: "GEYANTIME")

                let dt: Int = lt / 1000 / 60 / 60 / 24
                
                self.timeLab.text = "我们已经在在一起" + String(dt) + "天了"

            }
        }
        
        pickView.show()
    }

}
