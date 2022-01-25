//
//  NoteProtocol.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 14/01/22.
//

import Foundation

protocol NoteProtocol {
    var noteID: String { get }
    var content: String? { get set }
    var title: String? { get set }
}

extension Note: NoteProtocol {
    var noteID: String {
        objectID.uriRepresentation().absoluteString
    }
}
