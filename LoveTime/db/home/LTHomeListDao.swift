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
        let result: [LTHomeListModel]? = try? database.getObjects(fromTable: LT_LOVE_RECORD_TABLE_NAME, where: condion,orderBy: [LTHomeListModel.Properties.changeTime.asOrder(by: .descending)])
        if let r = result {
            return r
        }
        return []
    }
    
    func updateData(tid: Int,content: String) async {
        guard let database = LTDataBaseTool.default.base else {
            return
        }
        let entity = LTHomeListModel()
        entity.content = content
        
        let properites = [
            LTHomeListModel.Properties.content,
        ]
        
        do {
            try database.update(table: LT_LOVE_RECORD_TABLE_NAME, on: properites, with: entity, where: LTHomeListModel.Properties.tid == tid)
        } catch {
            print("\(#function) updateData error is \(error)")
        }
    }
}
