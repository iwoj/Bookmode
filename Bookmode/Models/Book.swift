//
//  Book.swift
//  Bookmode
//
//  Model representing a book
//

import Foundation

struct Book: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var author: String
    var currentPage: Int
    var totalPages: Int
    var notes: String
    var dateAdded: Date
    var lastRead: Date?
    var genre: String
    var coverImageURL: String?
    
    init(
        id: UUID = UUID(),
        title: String,
        author: String,
        currentPage: Int = 0,
        totalPages: Int,
        notes: String = "",
        dateAdded: Date = Date(),
        lastRead: Date? = nil,
        genre: String = "",
        coverImageURL: String? = nil
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.notes = notes
        self.dateAdded = dateAdded
        self.lastRead = lastRead
        self.genre = genre
        self.coverImageURL = coverImageURL
    }
    
    var progress: Double {
        guard totalPages > 0 else { return 0 }
        return Double(currentPage) / Double(totalPages)
    }
    
    var isFinished: Bool {
        currentPage >= totalPages
    }
}
