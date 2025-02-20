//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by Sasha Jaroshevskii on 20.02.2025.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withID: id)
    }
}
