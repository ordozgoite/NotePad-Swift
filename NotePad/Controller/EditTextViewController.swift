//
//  EditTextViewController.swift
//  NotePad
//
//  Created by Victor Ordozgoite on 17/05/22.
//

import UIKit

class EditTextViewController: UIViewController {
    
    @IBOutlet weak var noteText: UITextView!
    
    var selectedNote: Notes? {
        didSet {
            noteText.text = selectedNote?.text ?? ""
        }
    }
    var noteIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteText.textStorage.delegate = self
    }
}

extension EditTextViewController: NSTextStorageDelegate {
    func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        print("string: \(textStorage.string)")
    }
}
