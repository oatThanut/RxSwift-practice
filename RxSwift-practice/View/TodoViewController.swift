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
            .throttle(0.5, scheduler: MainScheduler.instance)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! CustomCell
        
        cell.decreaseButton.rx.tap.asObservable().debounce(0.5, scheduler: MainScheduler.instance).subscribe(onNext: { _ in
            //            print("Tapped [\(indexPath.row), -] \(todo.2)")
            self.viewModel.addOrRemove(str: "-", index: indexPath.row)
//            self.updateUI()
        }).disposed(by: cell.disposeBag)
        cell.increaseButton.rx.tap.asObservable().debounce(0.5, scheduler: MainScheduler.instance).subscribe(onNext: { _ in
            //            print("Tapped [\(indexPath.row), +] \(todo.2)")
            self.viewModel.addOrRemove(str: "+", index: indexPath.row)
//            self.updateUI()
        }).disposed(by: cell.disposeBag)
        
        let todo = viewModel.getContent(indexPath.row)
        cell.nameLabel.text = todo.0
        
        
//        cell.stepper.rx.value.asObservable().subscribe(
//            onNext: { (value) in
//            print(value)
//        }).disposed(by: cell.disposeBag)
        
        cell.numberTextField.text = "\(todo.2)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.changeTodoStatus(indexPath.row)
        updateUI()
    }

}

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var stepper: UIStepper!
    
    var disposeBag = DisposeBag()
    private let currentValue: BehaviorRelay<UInt> = BehaviorRelay(value: 1)
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
