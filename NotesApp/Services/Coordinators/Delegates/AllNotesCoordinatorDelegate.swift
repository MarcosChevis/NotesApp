//
//  AllNotesCoordinatorDelegate.swift
//  NotesApp
//
//  Created by Marcos Chevis on 28/01/22.
//

import Foundation

protocol AllNotesCoordinatorDelegate: AnyObject {
    func didDismiss()
    func didDismissToNote(with id: String)
}
