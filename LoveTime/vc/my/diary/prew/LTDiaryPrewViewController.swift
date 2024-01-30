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
            
            let contentH = self.model.content.boundingRect(with: CGSize(width: UIDevice.YH_Width - 40, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], context: nil).size.height + 1
            
            self.contentLab.snp.remakeConstraints { make in
                make.left.equalTo(self.view.snp_left).offset(20)
                make.right.equalTo(self.view.snp_right).offset(-20)
                make.top.equalTo(self.timeLab.snp_bottom).offset(10)
                make.height.equalTo(contentH)
            }
            
            var allH = contentH + 20 + 30 + 10 + 20

            if allH <= UIDevice.YH_Height - UIDevice.YH_Nav_Height {
                allH = UIDevice.YH_Height - UIDevice.YH_Nav_Height
            }
            self.scrollView.contentSize = CGSize(width: UIDevice.YH_Width, height: allH)
            
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        return scrollView
    }()
    
    lazy var nameLab: UILabel = {
        let nameLab = UILabel(frame: .zero)
        nameLab.font = UIFont.systemFont(ofSize: 18)
        nameLab.textAlignment = .center
        return nameLab
    }()
    
    lazy var timeLab: UILabel = {
        let timeLab = UILabel(frame: .zero)
        timeLab.font = UIFont.systemFont(ofSize: 14)
        timeLab.textAlignment = .center
        timeLab.textColor = UIColor.color0D1324().withAlphaComponent(0.5)
        return timeLab
    }()
    
    lazy var contentLab: UILabel = {
        let contentLab = UILabel(frame: .zero)
        contentLab.font = UIFont.systemFont(ofSize: 15)
        contentLab.numberOfLines = 0
        contentLab.textColor = UIColor.color0D1324().withAlphaComponent(0.5)
        return contentLab
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusNaviBar.hideNaviBar = false
        self.defaultNaviTitleLabel.text = "浏览日记"
        self.cusNaviBar.backgroundColor = UIColor.clear
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(nameLab)
        self.scrollView.addSubview(timeLab)
        self.scrollView.addSubview(contentLab)
        self.scrollView.contentInsetAdjustmentBehavior = .never

        scrollView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(UIDevice.YH_Width)
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(20)
        }
        
        self.nameLab.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp_left).offset(20)
            make.right.equalTo(self.view.snp_right).offset(-20)
            make.top.equalTo(self.scrollView.snp_top).offset(20)
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
