//
//  ListModeTableViewController.swift
//  Groovy Grow
//
//  Created by Sarah Drake on 3/22/17.
//  Copyright © 2017 groovy grow. All rights reserved.
//

import Foundation
import UIKit

class ListModeTableViewController: UITableViewController{
    
    weak var delegate: MarketListDelegate?
    var markets: [NSMutableDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
