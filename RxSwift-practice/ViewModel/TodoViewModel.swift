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
    private let privateDataSource: Variable<[TodoModel]>
    let dataSource: Observable<[TodoModel]>
    
    init() {
        todoList = DataSource.List.map(TodoModel.init)
        privateDataSource = Variable([])
        self.dataSource = privateDataSource.asObservable()
        privateDataSource.value = DataSource.List.map(TodoModel.init)
    }
    
    var numRow: Int {
        return privateDataSource.value.count
    }
    
    func getContent(_ index: Int) -> (String, String, Int) {
        let todo = privateDataSource.value[index]
        let status = todo.status ? "Done" : "Not done"
        return (todo.name, status, todo.num)
    }
    
    func addOrRemove(str: String, index: Int) {
        if str == "+" {
            todoList[index].num += 1
        } else if str == "-" {
            todoList[index].num -= 1
        }
    }
    
    func search(_ query: String) {
        privateDataSource.value = todoList.filter{$0.name.hasPrefix(query)}
        print(privateDataSource.value.map{$0.name})
    }
    
    func changeTodoStatus(_ index: Int) {
        let todo = todoList[index]
        todo.status = !todo.status
    }
    
    func AddTodo(name: String) {
        let todo = TodoModel(name: name)
        todoList.append(todo)
        DataSource.List[todo.name] = todo.status
        privateDataSource.value.append(todo)
    }
    
    func MarkAsDone(indexPath: Int) {
        todoList[indexPath].status = true
    }
}
