//
//  ViewController.swift
//  RxSwift-practice
//
//  Created by oatThanut on 6/6/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func AddBtn(_ sender: Any) {
        
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
