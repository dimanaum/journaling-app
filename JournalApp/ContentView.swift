import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \JournalEntry.date, order: .reverse) var journalEntries: [JournalEntry]
    @Environment(\.modelContext) private var modelContext

    @State private var selectedEntry: JournalEntry? // Tracks the currently selected entry
    @Environment(\.scenePhase) private var scenePhase // Tracks the app's lifecycle phase
    @State private var sidebarVisibility: NavigationSplitViewVisibility = .automatic // Tracks sidebar visibility

    var body: some View {
        NavigationSplitView(columnVisibility: $sidebarVisibility) {
            // Sidebar: List of journal entries grouped by month
            List(selection: $selectedEntry) {
                ForEach(groupedEntries.keys.sorted(by: >), id: \.self) { month in
                    Section(header: Text(month)) {
                        ForEach(groupedEntries[month] ?? []) { entry in
                            VStack(alignment: .leading) {
                                Text(entry.title)
                                    .font(.headline)
                                Text(entry.date, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .tag(entry) // Tag each row with the JournalEntry object
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    deleteEntry(entry)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: createNewEntry) {
                        Label("Add Entry", systemImage: "plus")
                    }
                }
            }
        } detail: {
            // Detail view dynamically updates based on the selected entry
            if let entry = selectedEntry {
                DetailView(entry: entry, onSave: saveEntry, onDelete: deleteEntry)
                    .id(entry.id) // Force the view to refresh when `entry.id` changes
            } else {
                Text("Select an entry to view or edit it")
                    .foregroundStyle(.secondary)
            }
        }
        .onChange(of: selectedEntry) { oldValue, newValue in
            // Save the previous entry before switching
            if let previousEntry = oldValue {
                saveEntry(previousEntry)
            }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            // Save the current entry when the app goes to the background
            if newPhase == .background, let entry = selectedEntry {
                saveEntry(entry)
            }
        }
    }

    // Helper function to group entries by month
    private var groupedEntries: [String: [JournalEntry]] {
        Dictionary(grouping: journalEntries) { entry in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy" // Group by "Month Year" (e.g., "November 2024")
            return formatter.string(from: entry.date)
        }
    }

    private func createNewEntry() {
        let newEntry = JournalEntry(title: "", content: "", date: Date())
        modelContext.insert(newEntry)
        selectedEntry = newEntry
    }

    private func deleteEntry(_ entry: JournalEntry) {
        if selectedEntry == entry {
            selectedEntry = nil // Clear the selection if the deleted entry is open
        }
        modelContext.delete(entry)
        do {
            try modelContext.save()
        } catch {
            print("Failed to delete entry: \(error.localizedDescription)")
        }
    }

    private func saveEntry(_ entry: JournalEntry) {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save entry: \(error.localizedDescription)")
        }
    }
}
