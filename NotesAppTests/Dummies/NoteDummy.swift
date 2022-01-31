//
//  NoteDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 17/01/22.
//

import Foundation
@testable import NotesApp

class NoteDummy: NoteProtocol {
    var noteID: String
    var content: String?
    var title: String?
    var allTags: [TagProtocol]
    
    init(noteID: String, content: String? = nil, title: String? = nil, allTags: [TagProtocol] = []) {
        self.noteID = noteID
        self.content = content
        self.title = title
        self.allTags = allTags
    }
    
    func addToTags(_ tag: TagProtocol) {
        allTags.append(tag)
    }
}
