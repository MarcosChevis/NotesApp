//
//  ThemesCollectionDataSouce.swift
//  NotesApp
//
//  Created by Nathalia do Valle Papst on 14/01/22.
//

import UIKit

class ThemesCollectionDataSouce: NSObject, UICollectionViewDataSource {
    private var data: [ColorSet] = ColorSet.allCases
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeCollectionViewCell.identifier, for: indexPath) as? ThemeCollectionViewCell
        else {
            preconditionFailure("Cell configured improperly")
        }
        
        cell.setupThemesViewCell(palette: data[indexPath.row])
        
        return cell
    }
    

}
