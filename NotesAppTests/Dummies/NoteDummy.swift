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
    
    init(noteID: String, content: String? = nil) {
        self.noteID = noteID
        self.content = content
    }
}
