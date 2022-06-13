//
//  Chat.swift
//  KMVVM
//
//  Created by sahib-dev on 6/13/22.
//

import Foundation

struct Message: Codable, Hashable {
    var message: String = ""
    var user: String = ""
    var hour: String = ""
    
    
    init(message: String, user: String, hour: String) {
        self.message = message
        self.user = user
        self.hour = hour
    }
}
