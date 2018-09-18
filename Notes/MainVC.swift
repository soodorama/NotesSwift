//
//  MainVC.swift
//  Notes
//
//  Created by Neil Sood on 9/17/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableData: [Note] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchAllNotes()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddEditSegue", sender: sender)
    }
    
    func fetchAllNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            let notes = try context.fetch(request)
            tableData = notes as [Note]
        } catch {
            print("\(error)")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        if sender is UIBarButtonItem {
            let addEditVC = nav.topViewController as! AddEditVC
            addEditVC.delegate = self
            addEditVC.data["header"] = "Add Note"
        }
        else {
            let indexPath = sender as! IndexPath
            if segue.identifier == "AddEditSegue" {
                let addEditVC = nav.topViewController as! AddEditVC
                addEditVC.delegate = self
                addEditVC.data["title"] = tableData[indexPath.row].title
                addEditVC.data["note"] = tableData[indexPath.row].note
                addEditVC.data["date"] = "9/17/2018"
                addEditVC.data["header"] = "Edit Note"
            }
            else if segue.identifier == "ViewSegue" {
                let viewVC = nav.topViewController as! ViewVC
                viewVC.data["title"] = tableData[indexPath.row].title
                viewVC.data["note"] = tableData[indexPath.row].note
                viewVC.data["date"] = "9/17/2018"
            }
        }
        
    }

}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.noteLabel.text = tableData[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.performSegue(withIdentifier: "AddEditSegue", sender: indexPath)
        }
        edit.backgroundColor = .gray
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let note = self.tableData[indexPath.row]
            self.context.delete(note)
            
            do {
                try self.context.save()
            } catch {
                print("\(error)")
            }
            
            self.tableData.remove(at: indexPath.row)
            tableView.reloadData()
        }
        delete.backgroundColor = .red
        
        return [delete, edit]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ViewSegue", sender: indexPath)
    }
    
}

extension MainVC: AddEditVCDelegate {
    
    func addNote(data: [String:Any?]) {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        note.title = data["title"] as! String
        note.note = data["note"] as! String
        note.date = data["date"] as! Date
        
        tableData.insert(note, at: 0)
        
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MainVC: ViewVCDelegate {
    func backBtnPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

