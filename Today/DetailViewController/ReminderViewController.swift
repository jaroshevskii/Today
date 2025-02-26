//
//  ReminderViewController.swift
//  Today
//
//  Created by Tamila Leschcenko on 27.02.2025.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    var reminder: Reminder
    
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
}
