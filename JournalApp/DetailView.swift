import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss

    @State var entry: JournalEntry
    let onSave: (JournalEntry) -> Void // Callback to save changes
    let onDelete: (JournalEntry) -> Void // Callback to delete the entry

    var body: some View {
        VStack {
            TextField("Title", text: $entry.title)
                .font(.largeTitle)
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)

            TextEditor(text: $entry.content)
                .padding(.horizontal)
                .padding(.top, 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .onDisappear {
            onSave(entry) // Save changes when the view disappears
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") {
                    closeAndSave()
                }
            }
            ToolbarItem(placement: .destructiveAction) {
                Button(role: .destructive) {
                    deleteAndClose()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }

    private func closeAndSave() {
        onSave(entry) // Save the entry
        dismiss()     // Dismiss the detail view
    }

    private func deleteAndClose() {
        onDelete(entry) // Delete the entry
        dismiss()       // Dismiss the detail view
    }
}
