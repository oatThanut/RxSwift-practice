//
//  TodoModel.swift
//  RxSwift-practice
//
//  Created by oatThanut on 6/6/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import Foundation

class TodoModel {
    
    let name: String
    var status: Bool
    var num: Int
    
    public init(name: String) {
        self.name = name
        self.status = false
        self.num = 1
    }
    
    public init(name: String, status: Bool) {
        self.name = name
        self.status = status
        self.num = 1
    }
}
