//
//  MainViewModel.swift
//  RxSwift-practice
//
//  Created by oatThanut on 6/6/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TodoViewModel {
    
    var todoList: [TodoModel]
    var showList:[TodoModel]
    var index: Int
    private let privateDataSource: Variable<[String]>
    let dataSource: Observable<[String]>
    
    init() {
        todoList = DataSource.List.map(TodoModel.init)
        showList = todoList
        index = 0
        privateDataSource = Variable([])
        self.dataSource = privateDataSource.asObservable()
    }
    
    var todoName: String {
        return todoList[index].name
    }
    
    var todoStatus: Bool {
        return todoList[index].status
    }
    
    var todoNum: Int {
        return todoList[index].num
    }
    
    func getContent(_ index: Int) -> (String, String, Int) {
        let todo = showList[index]
        let status = todo.status ? "Done" : "Not done"
        return (todo.name, status, todo.num)
    }
    
    func addOrRemove(str: String, index: Int) {
        if str == "+" {
            todoList[index].num += 1
        } else if str == "-" {
            todoList[index].num -= 1
        }
        print("Tapped [\(index), +] \(todoList[index].num)")
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
