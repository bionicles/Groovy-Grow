//
//  AddItemTableViewController.swift
//  Groovy Grow
//
//  Created by Sarah Drake on 3/16/17.
//  Copyright © 2017 groovy grow. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemTableViewControllerDelegate?
    var item: String?
    var indexPath: NSIndexPath?
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        print("Save button pressed")
        let text = itemTextField.text!
        delegate?.itemSaved(by: self, with: text, at: indexPath)
    }
    @IBOutlet weak var itemTextField: UITextField!
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        print("cancel button pressed")
        delegate?.cancelButtonPressed(by: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
