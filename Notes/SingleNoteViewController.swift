//
//  SingleNoteViewController.swift
//  Notes
//
//  Created by Madison Williams on 7/26/18.
//  Copyright © 2018 Madison Williams. All rights reserved.
//

import UIKit

class SingleNoteViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteContents: UITextView!
    
    var existingNote : Note?
    
    
    @IBAction func saveNote(_ sender: Any) {
        
        let currdate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        let myString = formatter.string(from: currdate)
        let yourDate: Date? = formatter.date(from: myString)
        let updatedString = formatter.string(from: yourDate!)
 
        
        let date = updatedString
        let contents = noteContents.text ?? "No Contents"
        let title = noteTitle.text ?? "No Title"
        
        var note : Note?
        
        if let existingNote = existingNote{
            existingNote.title = title
            existingNote.contents = contents
            existingNote.date = date
            
            note = existingNote
        }else{
            note = Note(title: title, contents: contents, date: date)
        }
        
        if let note = note{
            do{
                let managedContext = note.managedObjectContext
                try managedContext?.save()
                self.navigationController?.popViewController(animated: true)
                
            }catch{
                print("Context could not be saved")
            }
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTitle.text = existingNote?.title
        noteContents.text = existingNote?.contents
        
        if let date = existingNote?.date{
            dateLabel.text = "Last Edited: " + date
        }else{
            let currdate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
            let myString = formatter.string(from: currdate)
            let yourDate: Date? = formatter.date(from: myString)
            let updatedString = formatter.string(from: yourDate!)
            
            dateLabel.text = "Last Edited: " + updatedString
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
