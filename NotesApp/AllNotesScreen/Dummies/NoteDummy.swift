//
//  NoteDummy.swift
//  NotesApp
//
//  Created by Rebecca Mello on 18/01/22.
//

import Foundation

class NoteDummy: NoteProtocol {
    var noteID: String
    var content: String?
    
    init(noteID: String, content: String? = nil) {
        self.noteID = noteID
        self.content = content
    }
}
