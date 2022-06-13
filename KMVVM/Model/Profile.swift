//
//  Profile.swift
//  KMVVM
//
//  Created by sahib-dev on 6/13/22.
//

import Foundation

struct Profile: Codable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
