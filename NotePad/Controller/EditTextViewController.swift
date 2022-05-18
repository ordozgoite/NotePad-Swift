//
//  EditTextViewController.swift
//  NotePad
//
//  Created by Victor Ordozgoite on 17/05/22.
//

import UIKit

class EditTextViewController: UIViewController {
    
    @IBOutlet weak var noteText: UITextView!
    
    var selectedNote: Notes?
    let notesVC = NotesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteText.text = selectedNote?.text ?? ""
        noteText.textStorage.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let breakLine = "\n"
        let noteText = (selectedNote?.text) ?? ""
        
        if noteText != "" {
            if noteText.contains(breakLine) {
                if let token = selectedNote?.text?.components(separatedBy: breakLine) {
                    selectedNote?.title = token[0]
                    notesVC.saveItems()
                    navigationController?.viewControllers.first?.viewDidLoad()
                }
            } else {
                print("PASSOU AQUI!!!")
                selectedNote?.title = noteText
                notesVC.saveItems()
                navigationController?.viewControllers.first?.viewDidLoad()
            }
        } else {
            selectedNote?.title = "New Note"
            notesVC.saveItems()
            navigationController?.viewControllers.first?.viewDidLoad()
        }
    }
}

extension EditTextViewController: NSTextStorageDelegate {
    func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        print("string: \(textStorage.string)")
        
        selectedNote?.text = textStorage.string
        notesVC.saveItems()
    }
}
