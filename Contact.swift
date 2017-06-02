//
//  Contact.swift
//  SQLite_Contact_List
//
//  Created by Trevor MacGregor on 2017-06-01.
//  Copyright © 2017 TeevoCo. All rights reserved.
//

import Foundation

class Contact {
    
    let id:Int64
    var name: String
    var phone: String
    var address: String
    
    init(id:Int64) {
        self.id = id
        name = ""
        phone = ""
        address = ""
        
    }
    
    init(id:Int64, name:String, phone:String, address:String) {
        self.id = id
        self.name = name
        self.phone = phone
        self.address = address
    }
    
    
    
}
