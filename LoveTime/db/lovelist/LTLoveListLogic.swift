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

            let models = HYLocalPathManager.getLoveListWithFilePath()
            var lastModels : [LTLoveListModel] = []
            for item in models {
                
                let itemModel = LTLoveListModel()
                itemModel.name = item.name
                itemModel.content = item.content
                itemModel.imageName = item.imageName
                itemModel.typeName = item.typeName
                itemModel.type = item.type
                itemModel.changeTime = LTHomeListLogic.share.getTime()
                itemModel.create_Time = LTHomeListLogic.share.getNowTime()
                lastModels.append(itemModel)
            }
            
            if !lastModels.isEmpty {
                await LTLoveListDao.default.insertList(models: lastModels)
            }
        }
    }
    
    func queryAll() async -> [String: [LTLoveListModel]] {
        
        let list = await LTLoveListDao.default.queryAll()
                
        var m1: [LTLoveListModel] = []
        var m2: [LTLoveListModel] = []
        var m3: [LTLoveListModel] = []
        var m4: [LTLoveListModel] = []
        
        var lsatMap: [String: [LTLoveListModel]] = [:]
        
        for item in list {
            if item.typeName == "爱的初体验" {
                m1.append(item)
            }
            if item.typeName == "享受慢时光" {
                m2.append(item)
            }
            if item.typeName == "挑战不可能" {
                m3.append(item)
            }
            if item.typeName == "爱的高光时刻" {
                m4.append(item)
            }
        }
        
        lsatMap["爱的初体验"] = m1
        lsatMap["享受慢时光"] = m2
        lsatMap["挑战不可能"] = m3
        lsatMap["爱的高光时刻"] = m4
        return lsatMap
    }
    
    func updateData(model: LTLoveListModel) async {
        
        await LTLoveListDao.default.updateData(tid: model.ltId ?? 0, name: model.name, content: model.content, imageName: model.imageName)
    }
}
