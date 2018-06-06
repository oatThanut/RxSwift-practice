//
//  ViewController.swift
//  RxSwift-practice
//
//  Created by oatThanut on 6/6/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {
    
    var InputTextField: UITextField? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func AddBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Add ToDo List", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            self.InputTextField = textField
        })
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { alert -> Void in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancle", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

}

extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        return cell
    }
    
}
