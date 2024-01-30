//
//  HomeEditViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/5.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift
import MBProgressHUD

class HomeEditViewController: LTBaseViewController {

    var model: LTHomeListModel?
    
    var handleChangeModelCallback: (() -> Void)?

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
        
        self.homeEditView.getModel(model: self.model ?? LTHomeListModel())
        homeEditView.handleChooseImageCallback = { [weak self] in
            
            guard let self = self else { return }
            
            self.view.endEditing(true)
            self.showPhotoLibraryCanEdit(false, photo: { [weak self] img in
                
                guard let self = self else { return }
                
                if let im = img {
                    self.homeEditView.headImageView.image = im
                    let imageName = HYLocalPathManager.saveLocalImage(im)
                    if let m = self.homeEditView.model {
                        m.imageName = imageName
                    }
                }
                
            })
        }
        
        headNavView.handleCloseCallback = { [weak self] in
            
            guard let self = self else { return }
            self.view.endEditing(true)
            self.dismiss(animated: true)
        }
        
        headNavView.handleCompleteCallback = { [weak self] in
            
            guard let self = self else { return }
            
            self.view.endEditing(true)

            if let m = self.homeEditView.model {
                MBProgressHUD.showAdded(to: self.view, animated: true)
                Task {
                    if let s = self.homeEditView.contentTextView.text {
                        m.content = s
                    }
                    await LTHomeListLogic.share.updateData(model: m)
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.handleChangeModelCallback?()
                        self.dismiss(animated: true)
                    }
                }
            }
        }
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
