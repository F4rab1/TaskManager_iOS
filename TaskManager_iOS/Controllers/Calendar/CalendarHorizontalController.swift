//
//  CalendarHorizontalController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 26.07.2024.
//

import UIKit

class CalendarHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let dayCellId = "DayCell"
    private var selectedIndexPath: IndexPath? = IndexPath(item: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .yellow
        
        collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: dayCellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 60, height: view.frame.height - 30)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayCellId, for: indexPath) as! CalendarDayCell
        
        if indexPath == selectedIndexPath {
            cell.configureForSelectedState()
        } else {
            cell.configureForDeselectedState()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath,
           let previousCell = collectionView.cellForItem(at: previousIndexPath) as? CalendarDayCell {
            previousCell.configureForDeselectedState()
        }
        
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? CalendarDayCell {
            selectedCell.configureForSelectedState()
        }
        
        selectedIndexPath = indexPath
    }
    
}
