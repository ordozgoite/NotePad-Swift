//
//  EditTextViewController.swift
//  NotePad
//
//  Created by Victor Ordozgoite on 17/05/22.
//

import UIKit

class EditTextViewController: UIViewController {
    
    @IBOutlet weak var noteTextField: UITextView!
    
    var selectedNote: Notes?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextField.text = selectedNote?.text!
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let noteText = noteTextField.text!
        selectedNote?.text = noteText
        
        let breakLine = "\n"
        
        if noteText != "" {
            if noteText.contains(breakLine) {
                if let token = selectedNote?.text?.components(separatedBy: breakLine) {
                    selectedNote?.title = token[0]
                }
            } else {
                print(noteText)
                selectedNote?.title = noteText
                print(selectedNote?.title)
            }
        } else {
            selectedNote?.title = "New Note"
        }
        
        
        
        
        saveItems()
        navigationController?.viewControllers.first?.viewDidLoad()
    }
}

extension EditTextViewController {
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
    }
}

