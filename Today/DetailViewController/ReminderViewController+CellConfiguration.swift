//
//  ReminderViewController+CellConfiguration.swift
//  Today
//
//  Created by Tamila Leschcenko on 08.03.2025.
//

import UIKit

extension ReminderViewController {
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = text(for: row)
        contentConfig.textProperties.font = .preferredFont(forTextStyle: row.textStyle)
        contentConfig.image = row.image
        return contentConfig
    }
    
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = title
        return contentConfig
    }
    
    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Configuration {
        var contentConfig = cell.texFieldConfiguration()
        contentConfig.title = title
        return contentConfig
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        default: return nil
        }
    }
}
