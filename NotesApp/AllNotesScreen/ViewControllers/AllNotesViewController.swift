//
//  AllNotesViewController.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 12/01/22.
//

import UIKit

class AllNotesViewController: UIViewController {
    var palette: ColorSet

    init(palette: ColorSet) {
        self.palette = palette
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300.0))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [ item ])
                group.edgeSpacing = .init(leading: .fixed(0), top: .fixed(0), trailing: .fixed(0), bottom: .fixed(8))
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
                let section = NSCollectionLayoutSection(group: group)
                //section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 18.0, bottom: 0.0, trailing: 18.0)
                let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.backgroundColor = .red
        collectionView.backgroundColor = .secondarySystemBackground
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.strechToBounds(of: view)
        collectionView.dataSource = self
        collectionView.register(NoteSmallCellCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

}

extension AllNotesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NoteSmallCellCollectionViewCell else {
            fatalError()
        }
        
        cell.setup(with: .init(colorSet: .classic, title: "Um Grande titulo", content: "I have a dream that one day every valley shall be engulfed, every hill shall be exalted and every mountain shall…"), palette: palette)
        return cell
    }
    
    
}

protocol Stretchable {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
}

extension UIView: Stretchable {}
extension UILayoutGuide: Stretchable {}

extension UIView {
    
    @discardableResult
    func strechToBounds(of view: Stretchable) -> [NSLayoutConstraint] {
        let constraints = [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        return constraints
    }
}
