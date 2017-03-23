//
//  ShoppingListDelegate.swift
//  Groovy Grow
//
//  Created by Sarah Drake on 3/22/17.
//  Copyright © 2017 groovy grow. All rights reserved.
//

import Foundation
import UIKit

protocol MarketListDelegate: class {
    func getFarmerMarkets(by controller: UITableViewController, with markets: [NSMutableDictionary])
    
}
