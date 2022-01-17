//
//  NoteViewControllerTest.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 17/01/22.
//

import XCTest
@testable import NotesApp

class NoteViewControllerTest: XCTestCase {
    
    var repositoryDummy: NoteRepositoryDummy!
    var notificationServiceDummy: NotificationServiceDummy!
    var sut: NoteViewController!

    override func setUp() {
        repositoryDummy = .init()
        notificationServiceDummy = .init()
        sut = .init(palette: .classic, repository: repositoryDummy, notificationService: notificationServiceDummy)
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        repositoryDummy = nil
        notificationServiceDummy = nil
    }
    
    func testDidAddNote() {
        sut.didAdd()
        XCTAssertEqual(1, repositoryDummy.mock.count)
    }
}

class NoteRepositoryDummy: NotesRepositoryProtocol {
    var mock: [NoteCellViewModel] = []
    weak var delegate: NoteRepositoryProtocolDelegate?
    var didCallSaveChanges: Bool = false
    
    func saveChanges() throws {
        didCallSaveChanges = true
    }
    
    func deleteNote(_ note: NoteProtocol) throws {
        mock.removeAll(where: { $0.note.noteID == note.noteID })
    }
    
    func createEmptyNote() throws -> NoteProtocol {
        let vm = NoteCellViewModel.init(note: NoteDummy(noteID: UUID().uuidString, content: "Nota criada"))
        delegate?.insertNote(vm, at: IndexPath(row: mock.count, section: 0))
        mock.append(vm)
        return vm.note
        
    }
    
    func getInitialData() throws -> [NoteCellViewModel] {
        mock
    }
    
}

class NoteDummy: NoteProtocol {
    var noteID: String
    var content: String?
    
    init(noteID: String, content: String? = nil) {
        self.noteID = noteID
        self.content = content
    }
}

class NotificationServiceDummy: NotificationService {
    var postedNotification: [NSNotification.Name] = []
    var observers: [String] = []
    var removeObservers: [String] = []
    
    func post(name: NSNotification.Name, object: Any?) {
        postedNotification.append(name)
    }
    
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        observers.append(selector.description)
    }
    
    func removeObserver(_ observer: Any) {
        removeObservers.append("Removido")
    }
}
