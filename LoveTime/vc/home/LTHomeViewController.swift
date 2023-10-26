//
//  LTHomeViewController.swift
//  LoveTime
//
//  Created by Ocean 李 on 2023/10/16.
//

import UIKit
import SnapKit

class LTHomeViewController: LTBaseViewController {

    var cellCount: Int = 10

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.red
        
        self.view.addSubview(cardView)
        cardView.snp_makeConstraints { make in
            make.left.equalTo(self.view.snp_left).offset(50)
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(50)
            make.right.equalTo(self.view.snp_right).offset(-50)
            make.bottom.equalTo(self.view.snp_bottom).offset(-UIDevice.YH_Tabbar_Height)

        }
        
        self.cardView.dataSource = self
        self.cardView.delegate = self
        self.cardView.setCardLayout(cardLayout: self.cardLayout)
        self.cardView.register(nibCellType: HomeCardCell.self)
        self.cardView.reloadData()
    }
}

extension LTHomeViewController: GXCardCViewDataSource, GXCardCViewDelegate {
    

    
    func numberOfItems(in cardView: LTCardView) -> Int {
        return self.cellCount
    }
    func cardView(_ cardView: LTCardView, cellForItemAt indexPath: IndexPath) -> LTCardCell {
        let cell = cardView.dequeueReusableCell(for: indexPath, cellType: HomeCardCell.self)
//        cell.iconIView.image = UIImage(named: String(format: "banner%d.jpeg", indexPath.item%3))
//        cell.numberLabel.text = String(indexPath.item)
//        cell.leftLabel.isHidden = true
//        cell.rightLabel.isHidden = true
        
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
        if let toCell = cell as? HomeCardCell {
//            toCell.leftLabel.isHidden = !(direction == .right)
//            toCell.rightLabel.isHidden = !(direction == .left)
        }
    }
    func cardView(_ cardView: LTCardView, didRemove cell: LTCardCell, forItemAt index: Int, direction: HomeCardCell.SwipeDirection) {
        NSLog("didRemove forRowAtIndex = %d, direction = %d", index, direction.rawValue)
        if !cardView.cardLayout.isRepeat && index == 9 {
            self.cellCount = 20
            cardView.reloadData()
        }
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
