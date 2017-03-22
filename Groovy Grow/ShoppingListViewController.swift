//
//  ShowListViewController.swift
//  Groovy Grow
//
//  Created by Sarah Drake on 3/16/17.
//  Copyright © 2017 groovy grow. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    
//    let documentsUrl=FileManager.default.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last!
//    let fileUrl = documentsUrl.appendingPathComponent("myfile")
//    (items as NSDictionary).write(to: fileUrl, atomically:true)
//    let items = NSDictionary(contentsOf: fileUrl, atomically: true) as! [String]
    var items = [ListEntry]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//         Do any additional setup after loading the view, typically from a nib.
        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ListEntry")
        do {
            let results = try managedObjectContext.fetch(userRequest)
            items = results as! [ListEntry]
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //listens for anytime a row is clicked
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        print(indexPath.row)
        
        let item = items[indexPath.row]
//        print(item.name)
        items.remove(at: indexPath.row)
        managedObjectContext.delete(item)
        saveStuff()
        tableView.reloadData()

        
    }
    
    //sender is the object which calls this segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue"{
            print("add item segue if check")
        let navigationController = segue.destination as! UINavigationController
        let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
        addItemTableViewController.delegate = self
        } else if segue.identifier == "EditItemSegue"{
            print("edit item segue if check")
            let nav = segue.destination as! UINavigationController
            let addItemTableViewController = nav.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row].name
            addItemTableViewController.item = item
            addItemTableViewController.indexPath = indexPath
        }
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController){
        print("cancel button function in AddItemTable view controller")
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath:NSIndexPath?) {
        
        if let ip = indexPath {
            
            items[ip.row].name = text
            
            
        } else {
//            let newEntry = ListEntry(context: managedObjectContext)
//            newEntry.name = text
//            items.append(newEntry)
            let listEntry = NSEntityDescription.insertNewObject(forEntityName: "ListEntry", into: managedObjectContext) as! ListEntry
            listEntry.name = text
            items.append(listEntry)
            
            saveStuff()


        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)

    }

    func saveStuff(){
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print(error)
            }
        }
    }
    

}
