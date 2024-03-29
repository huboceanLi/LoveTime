//
//  LTHomeListLogic.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/11/8.
//

import Foundation

@objcMembers public class LTHomeListLogic: NSObject {
    
    static public let share = LTHomeListLogic()
    
    
    func firstSaveData() async -> Bool {

        let infos = await LTHomeListDao.default.queryWithTypeName(typeName: "生活")
        if infos.isEmpty {
            //save
            if let dic = self.getFileData() {
                
                var list : [LTHomeListModel] = []
                
                let keys = dic.allKeys
                
                for idx in 0..<keys.count {
                    
                    let k : String = keys[idx] as! String
                    print("\(k)")

                    if let d = dic[k] as? [String: Any] {
                        
                        if let arr = d["content"] as? Array<Any> {
                            
                            for index in 0..<arr.count - 1 {

                                if let item = arr[index] as? Dictionary<String, Any> {
                                    
                                    let itemModel = LTHomeListModel()

                                    itemModel.tid =  (idx + 1) * 100 + index
                                    itemModel.typeName = k
                                    itemModel.type = idx + 1
                                    itemModel.geyan = d["geyan"] as! String
                                    itemModel.name = item["title"] as! String
                                    itemModel.content = item["content"] as! String
                                    itemModel.address = item["address"] as! String
                                    itemModel.imageName = item["img"] as! String
                                    itemModel.changeTime = self.getTime()
                                    itemModel.create_Time = self.getNowTime()
                                    list.append(itemModel)
                                }
                            }
                        }
                    }
                }

                await LTHomeListDao.default.insertList(models: list)
                return true
            }
            return true
        }
        return true
    }

    func getFileData() -> NSDictionary? {
        
        if let filePath = Bundle.main.path(forResource: "reliankapian", ofType: "plist") {
            if let dictionary = NSDictionary(contentsOfFile: filePath) as? [String: Any] {
                // 成功加载字典
                return dictionary as NSDictionary
            } else {
                print("无法解析文件内容为字典")
                return nil
            }
        } else {
            print("文件不存在")
            return nil
        }
    }
    
    
    func getTime() -> Int {
        // 创建一个指定时间的日期对象
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let specifiedDate = dateFormatter.date(from: "2023-05-20") {
            // 获取指定时间的毫秒级时间戳
            let millisecondsSince1970 = Int(specifiedDate.timeIntervalSince1970 * 1000)
            print("指定时间的毫秒级时间戳: \(millisecondsSince1970)")
            return millisecondsSince1970
        } else {
            print("无法解析日期")
            return 0
        }
    }
    
    func getNowTime() -> Int {
        let currentDate = Date()
        let millisecondsSince1970 = Int(currentDate.timeIntervalSince1970 * 1000)
        return millisecondsSince1970
    }
    
    func queryWithTypeName(typeName: String) async -> [LTHomeListModel] {
        return await LTHomeListDao.default.queryWithTypeName(typeName: typeName)
    }
    
    func queryHomeListAll() async -> [String: [LTHomeListModel]] {
        
        let list = await LTHomeListDao.default.queryHomeListAll()
        let chatMessageMap = Dictionary.init(grouping: list, by: {$0.typeName})

        return  chatMessageMap
    }
    
    func convertTimestampToDateTime(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 定义日期时间格式
        
        let formattedDateTime = dateFormatter.string(from: date)
        
        return formattedDateTime
    }
    
    func updateData(model: LTHomeListModel) async {
        
        await LTHomeListDao.default.updateData(tid: model.tid, name: model.name, address: model.address, content: model.content, imageName: model.imageName, changeTime: model.changeTime)
    }
}
