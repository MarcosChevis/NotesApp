//
//  ThemesCollectionDataSource.swift
//  NotesApp
//
//  Created by Nathalia do Valle Papst on 14/01/22.
//

import UIKit

class ThemesCollectionDataSource: NSObject, UICollectionViewDataSource {
    var data: [ThemeCollectionData] = []
    let settings: Settings = .shared
    let themeRepository: ThemeRepositoryProtocol = ThemeRepository.shared
    #warning("refatorar essa parada")
    override init() {
        super.init()
        
        createData()
    }
    
    func createData() {
        data = []
        for cases in themeRepository.getAllThemes() {
            data.append(ThemeCollectionData(colorSet: cases, isSelected: settings.theme == cases))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeCollectionViewCell.identifier, for: indexPath) as? ThemeCollectionViewCell
        else {
            preconditionFailure("Cell configured improperly")
        }
        
        cell.setupThemesViewCell(palette: data[indexPath.row].colorSet, isSelected: data[indexPath.row].isSelected)
        
        return cell
    }
    

}



