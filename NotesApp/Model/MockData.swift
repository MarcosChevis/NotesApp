//
//  MockData.swift
//  NotesApp
//
//  Created by Marcos Chevis on 19/07/21.
//

import Foundation

class Singleton {
    
    static var shared: Singleton = Singleton()
    
    var data: [NoteData] = []
    
}
