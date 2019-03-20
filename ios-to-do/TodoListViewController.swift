//
//  ViewController.swift
//  ios-to-do
//
//  Created by jianyuan chen on 2019-03-19.
//  Copyright © 2019 Jianyuan Chen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let ITEMS = "ITEMS"
    var items = ["MADIOS-1", "MADIOS-2", "MADIOS-3"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        if let itemArr = defaults.array(forKey: self.ITEMS) as? [String] {
            items = itemArr
        }
        decorateNavigationItem()
    }
    
    func decorateNavigationItem() {
        let navItem: UINavigationItem = (self.navigationController?.navigationItem)!
        navItem.title = "Todoey"
        self.navigationController?.navigationBar.barTintColor = UIColor.green
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell;
    }
    
    // MARK: Editing cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.items.remove(at: indexPath.row)
            //            tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: Customize UIAlertController
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "What?", message: "Say something here", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.items.append(alert.textFields?.first?.text ?? "")
            
            self.defaults.set(self.items, forKey: self.ITEMS)
            
            self.tableView.reloadData()
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = "What's up?"
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}

