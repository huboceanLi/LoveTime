//
//  LTLoveListDao.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/7.
//

import Foundation
import WCDBSwift

private let LT_LOVE_LIST_TABLE_NAME = "LT_LOVE_LIST_TABLE_NAME"

struct LTLoveListDao {
    
    static var `default` = LTLoveListDao()
    
    func createTable(database: Database) {
        try? database.create(table: LT_LOVE_LIST_TABLE_NAME, of: LTLoveListModel.self)
    }
    
    func insertList(models: [LTLoveListModel]) async {
        
        guard let database = LTDataBaseTool.default.base else {
            return
        }
        
        if models.isEmpty {
            return
        }
        
        do {
            try database.insertOrReplace(objects: models, intoTable: LT_LOVE_LIST_TABLE_NAME)
        } catch  {
            print("\(#function) error : \(error)")
        }
    }
    
    func queryAll() async -> [LTLoveListModel] {
        guard let database = LTDataBaseTool.default.base else {
            return []
        }
        
        let condion: Condition = LTLoveListModel.Properties.ltId > 0
        let result: [LTLoveListModel]? = try? database.getObjects(fromTable: LT_LOVE_LIST_TABLE_NAME, where: condion)
        if let r = result {
            return r
        }
        return []
    }
    
}
