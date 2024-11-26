//
//  JournalEntry.swift
//  JournalApp
//
//  Created by Dmitriy Naumenko on 11/25/24.
//

import Foundation
import SwiftData

@Model
class JournalEntry {
    @Attribute(.unique) var id: UUID
    var title: String
    var content: String
    var date: Date

    init(title: String, content: String, date: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.date = date
    }
}
