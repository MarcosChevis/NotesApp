//
//  ThemeBuilderCollectionViewDataSource.swift
//  NotesApp
//
//  Created by Marcos Chevis on 26/01/22.
//

import UIKit

class CustomThemeBuilderCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var palette: CustomColorSet
    
    var data: [CustomColorData] = []
    
    init(colorSet: ThemeProtocol, palette: CustomColorSet) {
        self.palette = palette
        
        self.data.append(CustomColorData(name: "Background", color: colorSet.background))
        self.data.append(CustomColorData(name: "Note Background", color: colorSet.noteBackground))
        self.data.append(CustomColorData(name: "Text", color: colorSet.text))
        self.data.append(CustomColorData(name: "Title", color: colorSet.largeTitle))
        self.data.append(CustomColorData(name: "Buttons Background", color: colorSet.buttonBackground))
        self.data.append(CustomColorData(name: "Buttons", color: colorSet.actionColor))
        
        
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomThemeBuilderCollectionViewCell.identifier, for: indexPath) as? CustomThemeBuilderCollectionViewCell
        else {
            preconditionFailure("Cell configured improperly")
        }
        
        cell.setupCell(color: data[indexPath.row].color, colorName: data[indexPath.row].name, palette: palette)
        
        return cell
    }
    

}


