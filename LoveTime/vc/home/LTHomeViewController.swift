//
//  LTHomeViewController.swift
//  LoveTime
//
//  Created by Ocean 李 on 2023/10/16.
//

import UIKit
import SnapKit

class LTHomeViewController: LTBaseViewController {


    var list: [LTHomeListModel] = []
    
    private lazy var cardLayout: LTCardLayout = {
        let layout = LTCardLayout()
        layout.visibleCount = 4
        layout.maxAngle = 15.0
        layout.isRepeat = false
        layout.isPanAnimatedEnd = false //必须动画结束才可再次拖拽，为true时可不停的拖拽
        layout.maxRemoveDistance = self.view.frame.width/4
        layout.cardInsets = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: 10)
        
        return layout
    }()
    
    private lazy var cardView: LTCardView = {
        let cardView = LTCardView()
        return cardView
    }()
    
    private lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        moreButton.setImage(UIImage(named: "chat_list_more"), for: .normal)
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
        self.view.backgroundColor = UIColor.red
        
//        let welcomeMessage = NSLocalizedString("生活", comment: "test456")

        self.view.backgroundColor = .red
        self.cusNaviBar.hideNaviBar = false
        self.cusNaviBar.backgroundColor = UIColor.green
        self.defaultNaviBackButton.isHidden = true
        self.cusNaviBar.rightItems = self.rightItems
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
//        self.cusNaviBar.qmui_borderPosition = .bottom
//        self.cusNaviBar.qmui_borderWidth = BCDefine.seperateLineHeight()
//        self.cusNaviBar.qmui_borderColor = UIColor.clear
        
        self.view.addSubview(cardView)
        cardView.snp_makeConstraints { make in
            make.left.equalTo(self.view.snp_left).offset(40)
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(50)
            make.right.equalTo(self.view.snp_right).offset(-40)
            make.bottom.equalTo(self.view.snp_bottom).offset(-(UIDevice.YH_Tabbar_Height + 30))

        }
        
        self.cardView.dataSource = self
        self.cardView.delegate = self
        self.cardView.setCardLayout(cardLayout: self.cardLayout)
        self.cardView.register(nibCellType: HomeCardCell.self)
        self.cardView.reloadData()
        
        Task {
            let _ = await LTHomeListLogic.share.firstSaveData()
            
            if let str: String = UserDefaults.standard.object(forKey: "TITLENAME") as? String, str.count > 0 {
                self.list = await LTHomeListLogic.share.queryWithTypeName(typeName: str)
                self.cardView.reloadData()
            }else {
                UserDefaults.standard.setValue("生活", forKey: "TITLENAME")
                self.list = await LTHomeListLogic.share.queryWithTypeName(typeName: "生活")
                self.cardView.reloadData()
            }
            
        }
    }
    
    @objc private func moreAction() {
        
        let l = ["生活","欣赏","旅行","学习","运动","时光","享受"]
        let moreView = BCChatRightNavMoreView()
        moreView.frame = CGRectMake(0, 0, UIDevice.YH_Width, UIDevice.YH_Height)
        moreView.initUI(withItemNameArr:l, itemImageStrArr: ["chat_rightMore_newChat","chat_rightMore_addContact","chat_rightMore_scan","chat_rightMore_scan","chat_rightMore_scan","chat_rightMore_scan","chat_rightMore_scan"])
        UIApplication.shared.keyWindow?.addSubview(moreView)
        moreView.show()
        
        moreView.tapNumItem = { [weak self] itemIndex in
            guard let self = self else { return }

            Task {
                let ccc = Int(itemIndex)
                let sss = l[ccc]
                UserDefaults.standard.setValue(sss, forKey: "TITLENAME")
                self.list = await LTHomeListLogic.share.queryWithTypeName(typeName: sss)
                DispatchQueue.main.async {
                    self.cardView.reloadData()
                }
            }
        }
    }
}

extension LTHomeViewController: GXCardCViewDataSource, GXCardCViewDelegate {
        
    func numberOfItems(in cardView: LTCardView) -> Int {
        return self.list.count
    }
    func cardView(_ cardView: LTCardView, cellForItemAt indexPath: IndexPath) -> LTCardCell {
        let cell = cardView.dequeueReusableCell(for: indexPath, cellType: HomeCardCell.self)

        cell.getModel(model: self.list[indexPath.row])
        return cell
    }
    
    // MARK: - LTCardViewDelegate
    func cardView(_ cardView: LTCardView, didRemoveLast cell: LTCardCell, forItemAt index: Int, direction: HomeCardCell.SwipeDirection) {
        NSLog("didRemove forRowAtIndex = %d, direction = %d", index, direction.rawValue)
        if !cardView.cardLayout.isRepeat {
            cardView.reloadData()
            cardView.scrollToItem(at: 0, animated: false)
        }
    }
    func cardView(_ cardView: LTCardView, willRemove cell: LTCardCell, forItemAt index: Int, direction: LTCardCell.SwipeDirection) {
        NSLog("willRemove forRowAtIndex = %d, direction = %d", index, direction.rawValue)
//        if let toCell = cell as? HomeCardCell {
//            toCell.leftLabel.isHidden = !(direction == .right)
//            toCell.rightLabel.isHidden = !(direction == .left)
//        }
    }
    
    func cardView(_ cardView: LTCardView, didRemove cell: LTCardCell, forItemAt index: Int, direction: HomeCardCell.SwipeDirection) {
        NSLog("didRemove forRowAtIndex = %d, direction = %d", index, direction.rawValue)
//        if !cardView.cardLayout.isRepeat && index == 9 {
//            self.cellCount = 20
//            cardView.reloadData()
//        }
    }
    func cardView(_ cardView: LTCardView, didMove cell: LTCardCell, forItemAt index: Int, move point: CGPoint, direction: LTCardCell.SwipeDirection) {
        NSLog("move point = %@,  direction = %ld", point.debugDescription, direction.rawValue)
        if let toCell = cell as? HomeCardCell {
//            toCell.leftLabel.isHidden = !(direction == .right)
//            toCell.rightLabel.isHidden = !(direction == .left)
        }
    }
    func cardView(_ cardView: LTCardView, didDisplay cell: LTCardCell, forItemAt index: Int) {
        NSLog("didDisplay forRowAtIndex = %d", index)
    }
    func cardView(_ cardView: LTCardView, didSelectItemAt index: Int) {
        NSLog("didSelectItemAt index = %d", index)
    }
}
