//
//  Item.swift
//  Todoey
//
//  Created by Connor on 7/19/18.
//  Copyright © 2018 Connor. All rights reserved.
//

import Foundation


//need the codable here to allow the Item class to be encodable and decodable
class Item: Codable {
    var title : String = ""
    var done : Bool = false
}
