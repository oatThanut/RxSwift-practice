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
    var showList:[TodoModel]
    var index: Int
    
    init() {
        todoList = DataSource.List.map(TodoModel.init)
        showList = todoList
        index = 0
    }
    
    var todoName: String {
        return todoList[index].name
    }
    
    var todoStatus: Bool {
        return todoList[index].status
    }
    
    func getContent(_ index: Int) -> (String, String) {
        let todo = showList[index]
        let status = todo.status ? "Done" : "Not done"
        return (todo.name, status)
    }
    
    func search(_ query: String) {
        showList = todoList.filter{$0.name.hasPrefix(query)}
        print(showList.map{$0.name})
    }
    
    func changeTodoStatus(_ index: Int) {
        let todo = todoList[index]
        todo.status = !todo.status
    }
    
    func AddTodo(name: String) {
        let todo = TodoModel(name: name)
        todoList.append(todo)
        showList = todoList
        DataSource.List[todo.name] = todo.status
    }
    
    func MarkAsDone(indexPath: Int) {
        todoList[indexPath].status = true
    }
}
