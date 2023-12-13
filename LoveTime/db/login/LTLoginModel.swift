//
//  LTLoginModel.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import Foundation
import WCDBSwift
import YYModel

class LTLoginModel: NSObject, TableCodable {
    
    
    public var phone: String = ""
    public var name: String = ""
    public var imageName: String = ""
    public var pwd: String = ""


    
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = LTLoginModel
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)
       
        case phone
        case name
        case imageName
        case pwd

        public static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                phone: ColumnConstraintBinding(isPrimary: true),
                name: ColumnConstraintBinding(defaultTo: ""),
                imageName: ColumnConstraintBinding(defaultTo: ""),
                pwd: ColumnConstraintBinding(defaultTo: ""),
            ]
        }
    }
    
    public required override init() {}
}
