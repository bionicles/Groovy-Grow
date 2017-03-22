//
//  AddItemTableViewControllerDelegate.swift
//  Groovy Grow
//
//  Created by Sarah Drake on 3/16/17.
//  Copyright © 2017 groovy grow. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: AddItemTableViewController)
    
}
