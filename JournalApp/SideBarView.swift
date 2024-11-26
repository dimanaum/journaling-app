import SwiftUI

struct SidebarView: View {
    let journalEntries: [JournalEntry]
    @Binding var selectedEntry: JournalEntry?
    let onCreateNewEntry: () -> Void

    var body: some View {
        List(journalEntries, selection: $selectedEntry) { entry in
            VStack(alignment: .leading) {
                Text(entry.title)
                    .font(.headline)
                Text(entry.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .tag(entry) // Tags the row with the JournalEntry object
        }
        .navigationTitle("Journal")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: onCreateNewEntry) {
                    Label("Add Entry", systemImage: "plus")
                }
            }
        }
    }
}
