//
//  LTLoveListModel.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/7.
//

import Foundation
import WCDBSwift
import YYModel

class LTLoveListModel: NSObject, TableCodable {
    
    public var ltId: Int?
    public var name: String = ""
    public var content: String = ""
    public var imageName: String = ""
    public var type: Int = 0
    public var changeTime: Int = 0
    public var create_Time: Int = 0
    public var typeName: String = ""

    
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = LTLoveListModel
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)
       
        case ltId
        case name
        case content
        case imageName
        case type
        case typeName
        case changeTime
        case create_Time

        public static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
//                ltId: ColumnConstraintBinding(isPrimary: true),
                ltId: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
                name: ColumnConstraintBinding(defaultTo: ""),
                content: ColumnConstraintBinding(defaultTo: ""),
                imageName: ColumnConstraintBinding(defaultTo: ""),
                type: ColumnConstraintBinding(defaultTo: 0),
                typeName: ColumnConstraintBinding(defaultTo: ""),
                changeTime: ColumnConstraintBinding(defaultTo: 0),
                create_Time: ColumnConstraintBinding(defaultTo: 0),
            ]
        }
    }
    
    public required override init() {}
}
