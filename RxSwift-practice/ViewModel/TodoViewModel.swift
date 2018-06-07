//
//  MainViewModel.swift
//  RxSwift-practice
//
//  Created by oatThanut on 6/6/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import Foundation

class TodoViewModel {
    
    var todoList: [TodoModel]
    var index: Int
    
    init() {
        todoList = DataSource.List.map(TodoModel.init)
        index = 0
    }
    
    var todoName: String {
        return todoList[index].name
    }
    
    var todoStatus: Bool {
        return todoList[index].status
    }
    
    func getContent(_ index: Int) -> (String, String) {
        let todo = todoList[index]
        let status = todo.status ? "Done" : "Not done"
        return (todo.name, status)
    }
    
    func changeTodoStatus(_ index: Int) {
        let todo = todoList[index]
        todo.status = !todo.status
    }
    
    func AddTodo(name: String) {
        let todo = TodoModel(name: name)
        todoList.append(todo)
        DataSource.List[todo.name] = todo.status
    }
    
    func MarkAsDone(indexPath: Int) {
        todoList[indexPath].status = true
    }
}
