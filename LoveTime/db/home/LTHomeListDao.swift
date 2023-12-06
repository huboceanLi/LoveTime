//
//  LTHomeListDao.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/11/8.
//

import Foundation
import WCDBSwift

private let LT_LOVE_RECORD_TABLE_NAME = "LT_LOVE_RECORD_TABLE_NAME"

struct LTHomeListDao {
    
    static var `default` = LTHomeListDao()
    
    func createTable(database: Database) {
        try? database.create(table: LT_LOVE_RECORD_TABLE_NAME, of: LTHomeListModel.self)
    }
    
    func insertList(models: [LTHomeListModel]) async {
        
        guard let database = LTDataBaseTool.default.base else {
            return
        }
        
        if models.isEmpty {
            return
        }
        
        do {
            try database.insertOrReplace(objects: models, intoTable: LT_LOVE_RECORD_TABLE_NAME)
        } catch  {
            print("\(#function) error : \(error)")
        }
    }
    
    func queryWithTypeName(typeName: String) async -> [LTHomeListModel] {
        guard let database = LTDataBaseTool.default.base else {
            return []
        }
        
        let condion: Condition = LTHomeListModel.Properties.typeName == typeName
        let result: [LTHomeListModel]? = try? database.getObjects(fromTable: LT_LOVE_RECORD_TABLE_NAME, where: condion,orderBy: [LTHomeListModel.Properties.create_Time.asOrder(by: .descending)])
        if let r = result {
            return r
        }
        return []
    }

    
    func updateData(tid: Int, name: String, address: String, content: String, imageName: String, changeTime: Int) async {
        
        guard let database = LTDataBaseTool.default.base else {
            return
        }
        let entity = LTHomeListModel()
        entity.name = name
        entity.address = address
        entity.content = content
        entity.imageName = imageName
        entity.changeTime = changeTime
        entity.create_Time = LTHomeListLogic.share.getNowTime()
        let properites = [
            LTHomeListModel.Properties.name,
            LTHomeListModel.Properties.address,
            LTHomeListModel.Properties.content,
            LTHomeListModel.Properties.imageName,
            LTHomeListModel.Properties.changeTime,
        ]
        
        do {
            try database.update(table: LT_LOVE_RECORD_TABLE_NAME, on: properites, with: entity, where: LTHomeListModel.Properties.tid == tid)
        } catch {
            print("\(#function) updateData error is \(error)")
        }
    }
}
