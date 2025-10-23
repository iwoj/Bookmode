//
//  AddBookView.swift
//  Bookmode
//
//  View for adding a new book
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var bookManager: BookManager
    
    @State private var title = ""
    @State private var author = ""
    @State private var totalPages = ""
    @State private var currentPage = ""
    @State private var genre = ""
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Information")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    TextField("Genre (optional)", text: $genre)
                }
                
                Section(header: Text("Progress")) {
                    TextField("Total Pages", text: $totalPages)
                        .keyboardType(.numberPad)
                    
                    TextField("Current Page (optional)", text: $currentPage)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Notes (optional)")) {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        addBook()
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
    
    private var isValid: Bool {
        !title.isEmpty && !author.isEmpty && !totalPages.isEmpty && Int(totalPages) != nil
    }
    
    private func addBook() {
        guard let total = Int(totalPages) else { return }
        let current = Int(currentPage) ?? 0
        
        let book = Book(
            title: title,
            author: author,
            currentPage: current,
            totalPages: total,
            notes: notes,
            genre: genre
        )
        
        bookManager.addBook(book)
        dismiss()
    }
}

#Preview {
    AddBookView()
        .environmentObject(BookManager())
}
