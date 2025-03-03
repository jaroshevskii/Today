//
//  ReminderViewController+Section.swift
//  Today
//
//  Created by Sasha Jaroshevskii on 03.03.2025.
//

import Foundation

extension ReminderViewController {
    enum Section: Int, Hashable {
        case view
        case title
        case date
        case notes
        
        var name: String {
            switch self {
            case .view: ""
            case .title: NSLocalizedString("Title", comment: "Title section name")
            case .date: NSLocalizedString("Date", comment: "Date section name")
            case .notes: NSLocalizedString("Notes", comment: "Notes section name")
            }
        }
    }
}
