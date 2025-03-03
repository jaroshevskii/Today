//
//  ReminderViewController.swift
//  Today
//
//  Created by Tamila Leschcenko on 27.02.2025.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var reminder: Reminder
    private var dataSource: DataSource?
    
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfig.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfig)
        super.init(collectionViewLayout: listLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHeandler)
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        navigationItem.style = .navigator
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        
        updateSnapshot()
    }
    
    func cellRegistrationHeandler(cell: UICollectionViewListCell, indexPaht: IndexPath, row: Row) {
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = text(for: row)
        contentConfig.textProperties.font = .preferredFont(forTextStyle: row.textStyle)
        contentConfig.image = row.image
        cell.contentConfiguration = contentConfig
        cell.tintColor = .todayPrimaryTint
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        }
    }
    
    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        dataSource?.apply(snapshot)
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
