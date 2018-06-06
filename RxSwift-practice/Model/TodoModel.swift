//
//  TodoModel.swift
//  RxSwift-practice
//
//  Created by oatThanut on 6/6/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import Foundation

class TodoModel {
    
    let Name: String
    var status: Bool
    
    public init(name: String) {
        self.Name = name
        self.status = false
    }
}
