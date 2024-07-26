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
    private var calendarDays: [CalendarDay] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .yellow
        
        let today = Date()
        calendarDays = generateCalendarDays(startingFrom: today)
        print(calendarDays)
        
        collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: dayCellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 60, height: view.frame.height - 30)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayCellId, for: indexPath) as! CalendarDayCell
        cell.day = calendarDays[indexPath.item]
        
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

func generateCalendarDays(startingFrom startDate: Date, numberOfDays: Int = 14) -> [CalendarDay] {
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "en_US")
    var days: [CalendarDay] = []
    
    for offset in 0..<numberOfDays {
        if let dayDate = calendar.date(byAdding: .day, value: offset, to: startDate) {
            let components = calendar.dateComponents([.year, .month, .day, .weekday], from: dayDate)
            
            let month = String(calendar.monthSymbols[components.month! - 1].prefix(3))
            let dayString = String(components.day!)
            let weekDay = String(calendar.weekdaySymbols[components.weekday! - 1].prefix(3))
            
            let calendarDay = CalendarDay(month: month, day: dayString, weekDay: weekDay)
            days.append(calendarDay)
        }
    }
    
    return days
}
