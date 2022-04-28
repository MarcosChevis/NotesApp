//
//  NotesViewDelegate.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import Foundation

protocol NoteViewDelegate: AnyObject {
    func didAllNotes()
    func didAdd()
    func collectionViewDidMove(to indexPath: IndexPath)
    func collectionDidShowCells(of indexPaths: [IndexPath])
}
