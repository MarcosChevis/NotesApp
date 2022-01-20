//
//  TagProtocol.swift
//  NotesApp
//
//  Created by Rebecca Mello on 18/01/22.
//

import Foundation

protocol TagProtocol {
    var name: String? { get set }
    var tagID: String { get }
}

extension Tag: TagProtocol {
    var tagID: String {
        objectID.uriRepresentation().absoluteString
    }
}
