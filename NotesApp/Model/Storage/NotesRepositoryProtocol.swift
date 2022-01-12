//
//  NotesRepositoryProtocol.swift
//  NotesApp
//
//  Created by Rebecca Mello on 12/01/22.
//

import Foundation

protocol NotesRepositoryProtocol {
    func getNotes() -> [Note]
    func getAllTags() -> [Tag]
    func addNote(content: String) throws
    func deleteNote(_ note: Note) throws
    func editNote(_ note: Note) throws
}
