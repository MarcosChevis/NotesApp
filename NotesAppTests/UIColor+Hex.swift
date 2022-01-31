//
//  UIColor+Hex.swift
//  NotesAppTests
//
//  Created by Marcos Chevis on 27/01/22.
//

import XCTest
@testable import NotesApp
import UIKit

class UIColorHexExtension: XCTestCase {

    func testHexToColor() {
        let red = "ff0000"
        
        let color = UIColor(hex: red)!
        
        XCTAssertEqual([1, 0, 0, 1], color.cgColor.components)
    }
    
    func testColorToHex() {
        let color = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        let hex = color.toHex(alpha: true)
        
        XCTAssertEqual(hex, "FF0000FF")
    }

}
