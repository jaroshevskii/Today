//
//  ListViewController+DataSource.swift
//  Today
//
//  Created by Sasha Jaroshevskii on 26.01.2025.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = reminder.title
        contentConfig.secondaryText = reminder.dueDate.dateAndTimeText
        contentConfig.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfig
    }
}
