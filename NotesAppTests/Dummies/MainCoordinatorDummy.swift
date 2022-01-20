//
//  MainCoordinatorDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit
@testable import NotesApp

class MainCoordinatorDummy: MainCoordinatorProtocol {
    var didNavigateToAllNotes: Bool = false
    
    func navigateToAllNotes() {
        didNavigateToAllNotes = true
    }
}
