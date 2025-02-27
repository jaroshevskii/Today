//
//  ListViewController+DataSource.swift
//  Today
//
//  Created by Sasha Jaroshevskii on 26.01.2025.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    var remiderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }
    
    var remiderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }
    
    func updateSnapshot(reloading ids: [Reminder.ID] = []) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(reminders.map { $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource?.apply(snapshot)
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        let reminder = reminder(withID: id)
        
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = reminder.title
        contentConfig.secondaryText = reminder.dueDate.dateAndTimeText
        contentConfig.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfig
        
        var doneButtonConfig = doneButtonConfiguration(for: reminder)
        doneButtonConfig.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]
        cell.accessibilityValue = reminder.isComplete ? remiderCompletedValue : remiderNotCompletedValue
        cell.accessories = [
            .customView(configuration: doneButtonConfig),
            .disclosureIndicator(displayed: .always),
        ]
        
        var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfig.backgroundColor = .todayListCellBackground
    }
    
    func reminder(withID id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withID: id)
        return reminders[index]
    }
    
    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfReminder(withID: reminder.id)
        reminders[index] = reminder
    }
    
    func completeReminder(withID id: Reminder.ID) {
        var reminder = reminder(withID: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
    }
    
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle completion", comment: "Reminder done button accesssibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeReminder(withID: reminder.id)
            return true
        }
        return action
    }
    
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfig = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfig)
        let button = ReminderDoneButton()
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}
