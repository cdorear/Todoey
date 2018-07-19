//
//  ViewController.swift
//  Todoey
//
//  Created by Connor on 7/14/18.
//  Copyright © 2018 Connor. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    //more detail about this item array in the quizzler module
    var itemArray = [Item]()

    //creates new object that uses the UserDefaults interface to the user database where you store key value pairs persistently across launches of the app
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items
        }
    }

 
    //Want the three items in the itemArray to be listed in three separate cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
       
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        above code does the same thing
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
//
        return cell
    
    }
    //MARK -TableView Delegate Method that gets fired whenever you select something from the table view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        //prints number into debug console
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        //forces table view to call its data source methods again so that it reloads data that is meant to be inside
        tableView.reloadData()
        
        //everytime you select the cell it will add a checkmark. Got rid of this with the cell.accessory type code above
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        //animates the deselction once the item has been tapped. 
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    //Mark - Add New Items (uses a press on the bar button item to add a new item to the todo list)
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on UIAlert. We want to append the item array to include whatever is added to the add item button. Because we are inside a close (see the "in" above) we have to specify self to specify that the item array exists within the current class
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
        
            //saving the item array to the user default will allow it to persist
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            
            //need to reload the data for the itemArray to take into account the newly added item
            self.tableView.reloadData()
        
        }
        
        
        
        //want to add text field to the alert so that we can add in the new item instead of just having it display "New Item
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

