//
//  JSONDecoderUtilities.swift
//  NotesApp
//
//  Created by Marcos Chevis on 28/01/22.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(from fileName: String, decodeTo type: T.Type) -> T? {
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url, options: .mappedIfSafe),
            let decodedData = try? decode(type, from: data)
        else {
            return nil
        }
        
        return decodedData
    }
}
