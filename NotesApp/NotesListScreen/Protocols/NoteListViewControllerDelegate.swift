//
//  NoteListViewControllerDelegate.swift
//  NotesApp
//
//  Created by Marcos Chevis on 20/07/21.
//

import Foundation

protocol NoteListViewControllerDelegate: AnyObject {
    func updateText(coreDataObject: Note)
}
