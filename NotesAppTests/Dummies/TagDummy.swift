//
//  TagDummy.swift
//  NotesApp
//
//  Created by Rebecca Mello on 18/01/22.
//

import Foundation
@testable import NotesApp

class TagDummy: TagProtocol {
    var name: String?
    var tagID: String
    
    init(name: String? = nil, tagID: String) {
        self.name = name
        self.tagID = tagID
    }
}
