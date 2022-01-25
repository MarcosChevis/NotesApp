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
    var allTags: [TagProtocol] { get }
    
    func addToTags(_ tag: TagProtocol)
}

extension Note: NoteProtocol {
    var allTags: [TagProtocol] {
        get {
            guard let array = tags?.allObjects as? [Tag] else {
                return []
            }
            
            return array
        }
    }
    
    var noteID: String {
        objectID.uriRepresentation().absoluteString
    }
    
    func addToTags(_ tag: TagProtocol) {
        guard let entity = tag as? Tag else { return }
        addToTags(entity)
    }
}
