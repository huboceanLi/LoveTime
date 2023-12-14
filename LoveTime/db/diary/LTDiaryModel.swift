//
//  LTDiaryModel.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/14.
//

import Foundation
import WCDBSwift
import YYModel

class LTDiaryModel: NSObject, TableCodable {
    
    
    public var ltId: Int?
    public var name: String = ""
    public var content: String = ""
    public var create_Time: Int = 0


    
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = LTDiaryModel
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)
       
        case ltId
        case name
        case content
        case create_Time

        public static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                ltId: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
                name: ColumnConstraintBinding(defaultTo: ""),
                content: ColumnConstraintBinding(defaultTo: ""),
                create_Time: ColumnConstraintBinding(defaultTo: 0),
            ]
        }
    }
    
    public required override init() {}
}
