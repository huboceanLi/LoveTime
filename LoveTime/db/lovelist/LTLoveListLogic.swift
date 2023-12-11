//
//  LTLoveListLogic.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/7.
//

import Foundation

@objcMembers public class LTLoveListLogic: NSObject {
    
    static public let share = LTLoveListLogic()
    
    func firstSaveData() async {
        
        let list = await LTLoveListDao.default.queryAll()
        if list.isEmpty {
            if let arr = self.getFileData() {
                
                HYLocalPathManager.getLoveListWithFilePath()
//                var list : [LTLoveListModel] = []
//                for idx in 0..<arr.count {
//                    
//                    if let d = arr[idx] as? [String: Any] {
//                        
//                        let itemModel = LTLoveListModel()
//                        itemModel.typeName = d["name"] as! String
//                        
//                        if let itemArray = d["des"] as! Array<[String: Any]> {
//                            
//                        }
//
//                        
//                    }
//                    
//
//                }
            }
            

        }
    }
    
    func getFileData() -> NSArray? {
        
        if let filePath = Bundle.main.path(forResource: "lianaiqingdan", ofType: "plist") {
            
            if let array = NSArray(contentsOfFile: filePath) {
                return array
            }
//            if let dictionary = NSDictionary(contentsOfFile: filePath) as? [String: Any] {
//                // 成功加载字典
//                return dictionary as NSDictionary
//            }
            else {
                print("无法解析文件内容为字典")
                return nil
            }
        } else {
            print("文件不存在")
            return nil
        }
    }
}
