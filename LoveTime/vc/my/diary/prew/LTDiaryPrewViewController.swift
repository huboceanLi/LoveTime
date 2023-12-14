//
//  LTDiaryPrewViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import UIKit
import SnapKit

class LTDiaryPrewViewController: LTBaseViewController {

    var model: LTDiaryModel = LTDiaryModel()
    {
        didSet {
            
            self.nameLab.text = self.model.name
            self.timeLab.text = LTHomeListLogic.share.convertTimestampToDateTime(timestamp: TimeInterval(self.model.create_Time/1000))
            self.contentLab.text = self.model.content
        }
    }
    
    lazy var nameLab: UILabel = {
        let nameLab = UILabel(frame: .zero)
        nameLab.font = UIFont.systemFont(ofSize: 15)
        nameLab.textAlignment = .center
        return nameLab
    }()
    
    lazy var timeLab: UILabel = {
        let timeLab = UILabel(frame: .zero)
        timeLab.font = UIFont.systemFont(ofSize: 15)
        timeLab.textAlignment = .center
        return timeLab
    }()
    
    lazy var contentLab: UILabel = {
        let contentLab = UILabel(frame: .zero)
        contentLab.font = UIFont.systemFont(ofSize: 15)
        contentLab.numberOfLines = 0
        return contentLab
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusNaviBar.hideNaviBar = false
        self.defaultNaviTitleLabel.text = "浏览日记"
        self.cusNaviBar.backgroundColor = UIColor.clear
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        
        self.view.addSubview(nameLab)
        self.view.addSubview(timeLab)
        self.view.addSubview(contentLab)
        
        self.nameLab.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp_left).offset(20)
            make.right.equalTo(self.view.snp_right).offset(-20)
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(20)
            make.height.equalTo(30)
        }

        self.timeLab.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp_left).offset(20)
            make.right.equalTo(self.view.snp_right).offset(-20)
            make.top.equalTo(self.nameLab.snp_bottom).offset(10)
            make.height.equalTo(20)
        }
        
//        self.contentLab.snp.makeConstraints { make in
//            make.left.equalTo(self.view.snp_left).offset(20)
//            make.right.equalTo(self.view.snp_right).offset(-20)
//            make.top.equalTo(self.timeLab.snp_bottom).offset(10)
//            make.height.equalTo(20)
//        }
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
