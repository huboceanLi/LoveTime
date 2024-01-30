//
//  LTLoveEditViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/12.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift
import MBProgressHUD

class LTLoveEditViewController: LTBaseViewController {

    var model: LTLoveListModel?
    
    var handleChangeModelCallback: (() -> Void)?

    lazy var headNavView: HeadNavView = {
        let headNavView = HeadNavView(frame: .zero)
        return headNavView
    }()
    
    lazy var editView: LTLoveEditView = {
        let editView = LTLoveEditView(frame: .zero)
        return editView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        
        IQKeyboardManager.shared.enableAutoToolbar = true

        self.editView.getModel(model: self.model ?? LTLoveListModel())
        editView.handleChooseImageCallback = { [weak self] in
            
            guard let self = self else { return }
            
            self.view.endEditing(true)
            self.showPhotoLibraryCanEdit(false, photo: { [weak self] img in
                
                guard let self = self else { return }
                
                if let im = img {
                    self.editView.headImageView.image = im
                    let imageName = HYLocalPathManager.saveLocalImage(im)
                    if let m = self.editView.model {
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

            if let m = self.editView.model {
                MBProgressHUD.showAdded(to: self.view, animated: true)
                Task {
                    if let s = self.editView.contentTextView.text {
                        m.content = s
                    }
                    await LTLoveListLogic.share.updateData(model: m)
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

        
        IQKeyboardManager.shared.enableAutoToolbar = true

        self.view.addSubview(editView)

        editView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.headNavView.snp_bottom).offset(0)
        }
        
    }

}
