import SwiftUI

struct DetailViewContainer: View {
    @Binding var selectedEntry: JournalEntry?
    let newEntryID: UUID?
    let journalEntries: [JournalEntry]
    let onSaveEntry: (JournalEntry) -> Void
    let onDeleteEntry: (JournalEntry) -> Void // Add onDeleteEntry as a parameter

    var body: some View {
        if let entry = selectedEntry ?? journalEntries.first(where: { $0.id == newEntryID }) {
            DetailView(entry: entry, onSave: onSaveEntry, onDelete: onDeleteEntry) // Pass onDeleteEntry
        } else {
            Text("Select an entry to view or edit it")
                .foregroundStyle(.secondary)
        }
    }
}
