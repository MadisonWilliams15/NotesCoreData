//
//  NotesViewController.swift
//  Notes
//
//  Created by Madison Williams on 7/26/18.
//  Copyright © 2018 Madison Williams. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {


    @IBOutlet weak var notesTableView: UITableView!
    
    var notes = [Note]()
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        do{
            notes = try managedContext.fetch(fetchRequest)
            notesTableView.reloadData()
            
        }catch{
            print("Fetch could not be performed")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   
    @IBAction func addNote(_ sender: Any) {
        performSegue(withIdentifier: "showNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let row = notesTableView.indexPathForSelectedRow?.row,
            let destination = segue.destination as? SingleNoteViewController{
            destination.existingNote = notes[row]
        }

    }
    
    func deleteNote(at indexPath : IndexPath){
        let note = notes[indexPath.row]
        
        if let managedContext = note.managedObjectContext{
            managedContext.delete(note)
            
            do{
                try managedContext.save()
                
                self.notes.remove(at: indexPath.row)
                
                notesTableView.deleteRows(at: [indexPath], with: .automatic)
            }catch{
                print("Delete failed")
                
                notesTableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
        }
        
        
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

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.title
        
      
        
        if let date = note.date {
            cell.detailTextLabel?.text = date
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteNote(at: indexPath)
        }
    }
    
}


extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNote", sender: self)
    }
}
