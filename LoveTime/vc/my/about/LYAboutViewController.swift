//
//  LYAboutViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import UIKit
import SnapKit

class LYAboutViewController: LTBaseViewController {

    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView(frame: .zero)
        headImageView.image = UIImage(named: "about_Img")
        headImageView.layer.cornerRadius = 8.0
        headImageView.layer.masksToBounds = true
        return headImageView
    }()
//    
//    lazy var viewTap: UITapGestureRecognizer = {
//        let tap = UITapGestureRecognizer.init()
//        tap.addTarget(self, action: #selector(tapView(gestrue:)))
//        return tap
//    }()
//    
    lazy var nameLab: UILabel = {
        let nameLab = UILabel(frame: .zero)
        nameLab.font = UIFont.systemFont(ofSize: 16)
        return nameLab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusNaviBar.hideNaviBar = false
        self.defaultNaviTitleLabel.text = "关于"
        self.cusNaviBar.backgroundColor = UIColor.clear
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        
        self.view.addSubview(headImageView)
        self.view.addSubview(nameLab)
        
        headImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.height.width.equalTo(90)
        }
        
        nameLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.headImageView.snp_bottom).offset(4)
            make.height.equalTo(16)
        }
        if let s = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            nameLab.text = "v " + s
        }else {
            nameLab.text = "v 1.0.0"
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
