//
//  BookManager.swift
//  Bookmode
//
//  Manages the collection of books
//

import Foundation
import SwiftUI

class BookManager: ObservableObject {
    @Published var books: [Book] = []
    
    private let booksKey = "saved_books"
    
    init() {
        loadBooks()
    }
    
    func addBook(_ book: Book) {
        books.append(book)
        saveBooks()
    }
    
    func updateBook(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index] = book
            saveBooks()
        }
    }
    
    func deleteBook(_ book: Book) {
        books.removeAll { $0.id == book.id }
        saveBooks()
    }
    
    func deleteBooks(at offsets: IndexSet) {
        books.remove(atOffsets: offsets)
        saveBooks()
    }
    
    func getCurrentlyReadingBooks() -> [Book] {
        books.filter { !$0.isFinished && $0.currentPage > 0 }
    }
    
    func getRandomBook() -> Book? {
        let currentlyReading = getCurrentlyReadingBooks()
        return currentlyReading.isEmpty ? books.randomElement() : currentlyReading.randomElement()
    }
    
    private func saveBooks() {
        if let encoded = try? JSONEncoder().encode(books) {
            UserDefaults.standard.set(encoded, forKey: booksKey)
        }
    }
    
    private func loadBooks() {
        if let data = UserDefaults.standard.data(forKey: booksKey),
           let decoded = try? JSONDecoder().decode([Book].self, from: data) {
            books = decoded
        }
    }
}
