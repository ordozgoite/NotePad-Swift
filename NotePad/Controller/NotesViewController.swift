//
//  ViewController.swift
//  NotePad
//
//  Created by Victor Ordozgoite on 17/05/22.
//

import UIKit
import CoreData

class NotesViewController: UITableViewController {
    
    var notesArray = [Notes]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("VIEW DID LOAD")
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
    }
    
    //MARK: - Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        // Add New Note In The List

        let newNote = Notes(context: self.context)
        newNote.title = "New Note"
        newNote.text = ""
        
        notesArray.append(newNote)

        saveItems()

        // Go To The New Note
        
        performSegue(withIdentifier: "GoToNote", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EditTextViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedNote = notesArray[indexPath.row]
        }
        
        // Passar objeto Notes() para a próxima View Controller
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "GoToNote", sender: self)
    }
}

//MARK: - TableView Datasources Methods

extension NotesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let note = notesArray[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "NoteCell")
        
        cell.textLabel?.text = note.title
        
        return cell
    }
}

//MARK: - Data Manipulation Methods

extension NotesViewController {
    func saveItems() {

        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }

        tableView.reloadData()
    }

    func loadItems(with request: NSFetchRequest<Notes> = Notes.fetchRequest()) {

        do {
            notesArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }

        tableView.reloadData()
    }
}

