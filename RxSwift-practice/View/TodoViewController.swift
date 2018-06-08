//
//  TodoViewController.swift
//  RxSwift-practice
//
//  Created by oatThanut on 6/6/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TodoViewController: UITableViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    var InputTextField: UITextField? = nil
    let disposeBag = DisposeBag()
    
    let viewModel = TodoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        addBinding()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddBtn(_ sender: Any) {
        let add = UIAlertController(title: "Add TODO List", message: "", preferredStyle: .alert)
        add.addTextField { (textField) in
            self.InputTextField = textField
        }
        add.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            guard let name = self.InputTextField?.text else { return }
            if name != "" {
                self.viewModel.AddTodo(name: name)
            }
            self.updateUI()
        }))
        add.addAction(UIAlertAction(title: "Cancle", style: .default, handler: nil))
        
        present(add, animated: true)
    }
    
    func addBinding() {
        searchBar.rx.text
            .orEmpty
            .subscribe(onNext: { query in
                self.viewModel.search(query)
                self.updateUI()
            })
            .disposed(by: disposeBag)
    }
    
    func updateUI() {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.showList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        let todo = viewModel.getContent(indexPath.row)
        cell.textLabel?.text = "\(todo.0)        \(todo.1)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.changeTodoStatus(indexPath.row)
        updateUI()
    }

}
