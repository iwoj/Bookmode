//
//  BooksView.swift
//  Bookmode
//
//  Main view for displaying and managing books
//

import SwiftUI

struct BooksView: View {
    @EnvironmentObject var bookManager: BookManager
    @State private var showingAddBook = false
    @State private var selectedBook: Book?
    
    var body: some View {
        NavigationView {
            Group {
                if bookManager.books.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "books.vertical")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No Books Yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Add your first book to get started")
                            .foregroundColor(.gray)
                        
                        Button(action: { showingAddBook = true }) {
                            Label("Add Book", systemImage: "plus.circle.fill")
                                .font(.headline)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top)
                    }
                } else {
                    List {
                        Section(header: Text("Currently Reading")) {
                            ForEach(bookManager.getCurrentlyReadingBooks()) { book in
                                BookRow(book: book)
                                    .onTapGesture {
                                        selectedBook = book
                                    }
                            }
                        }
                        
                        Section(header: Text("All Books")) {
                            ForEach(bookManager.books) { book in
                                BookRow(book: book)
                                    .onTapGesture {
                                        selectedBook = book
                                    }
                            }
                            .onDelete(perform: bookManager.deleteBooks)
                        }
                    }
                }
            }
            .navigationTitle("My Books")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddBook = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView()
            }
            .sheet(item: $selectedBook) { book in
                BookDetailView(book: book)
            }
        }
    }
}

struct BookRow: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(book.title)
                .font(.headline)
            
            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                ProgressView(value: book.progress)
                    .progressViewStyle(.linear)
                
                Text("\(Int(book.progress * 100))%")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(width: 45, alignment: .trailing)
            }
            
            Text("Page \(book.currentPage) of \(book.totalPages)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

struct BookDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var bookManager: BookManager
    @State private var book: Book
    
    init(book: Book) {
        _book = State(initialValue: book)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Info")) {
                    Text("Title: \(book.title)")
                    Text("Author: \(book.author)")
                    if !book.genre.isEmpty {
                        Text("Genre: \(book.genre)")
                    }
                }
                
                Section(header: Text("Progress")) {
                    HStack {
                        Text("Current Page")
                        Spacer()
                        TextField("Page", value: $book.currentPage, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                    }
                    
                    Text("Total Pages: \(book.totalPages)")
                    
                    ProgressView(value: book.progress)
                    
                    Text("\(Int(book.progress * 100))% Complete")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $book.notes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Book Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        bookManager.updateBook(book)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    BooksView()
        .environmentObject(BookManager())
}
