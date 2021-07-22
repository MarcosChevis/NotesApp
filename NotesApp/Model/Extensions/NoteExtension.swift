//
//  NoteExtension.swift
//  NotesApp
//
//  Created by Marcos Chevis on 22/07/21.
//

import CoreData

extension Note {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.creationDate = Date()
    }
}
