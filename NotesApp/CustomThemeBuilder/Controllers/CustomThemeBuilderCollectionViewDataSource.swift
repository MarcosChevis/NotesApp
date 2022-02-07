//
//  ThemeBuilderCollectionViewDataSource.swift
//  NotesApp
//
//  Created by Marcos Chevis on 26/01/22.
//

import UIKit

class CustomThemeBuilderCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var palette: ColorSet
    
    var data: [CustomColorData] = []
    
    init(colorSet: ThemeProtocol, palette: ColorSet) {
        self.palette = palette
        
        self.data.append(CustomColorData(name: NSLocalizedString(.background), color: colorSet.background))
        self.data.append(CustomColorData(name: NSLocalizedString(.noteBackground), color: colorSet.noteBackground))
        self.data.append(CustomColorData(name: NSLocalizedString(.text), color: colorSet.text))
        self.data.append(CustomColorData(name: NSLocalizedString(.largeTitle), color: colorSet.largeTitle))
        self.data.append(CustomColorData(name: NSLocalizedString(.buttonBackground), color: colorSet.buttonBackground))
        self.data.append(CustomColorData(name: NSLocalizedString(.actionColor), color: colorSet.actionColor))
        
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


