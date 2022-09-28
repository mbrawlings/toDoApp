//
//  ViewController.swift
//  toDoApp
//
//  Created by Matthew Rawlings on 9/28/22.
//

import UIKit

struct ToDo {
    var name: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var toDos = [
        ToDo(name: "Do the dishes"),
        ToDo(name: "Do some more code"),
        ToDo(name: "Mow the lawn")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Action Outlets
    @IBAction func addButtonTapped(_ sender: Any) {
        let indexPath = IndexPath(row: toDos.count, section: 0)
        toDos.append(ToDo(name: "Eat a chip"))
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editButtonTapped(_:)))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped(_:)))
        }
    }
    
    //MARK: - Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
        cell.textLabel?.text = toDos[indexPath.row].name
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let toDo = toDos[sourceIndexPath.row]
        toDos.remove(at: sourceIndexPath.row)
        toDos.insert(toDo, at: destinationIndexPath.row)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            break
        case .none:
            break
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My To Do List"
    }
}

