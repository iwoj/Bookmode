//
//  AIService.swift
//  Bookmode
//
//  Generates AI-powered book prompts and notifications
//

import Foundation

class AIService {
    private let apiKey: String?
    private let baseURL = "https://api.openai.com/v1/chat/completions"
    
    init() {
        // In production, this should be loaded from a secure location like Keychain
        // For now, users need to add their API key in Settings
        self.apiKey = UserDefaults.standard.string(forKey: "openai_api_key")
    }
    
    func generateBookPrompt(for book: Book) async -> String {
        guard let apiKey = apiKey, !apiKey.isEmpty else {
            return generateFallbackPrompt(for: book)
        }
        
        let prompt = """
        Generate a brief, engaging notification (max 100 characters) to encourage someone to stop scrolling social media and read their book "\(book.title)" by \(book.author). They're currently on page \(book.currentPage) of \(book.totalPages). Make it personal and intriguing, perhaps teasing what might happen next or why they should return to the story now.
        """
        
        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are a helpful assistant that creates engaging, brief reading prompts."],
                ["role": "user", "content": prompt]
            ],
            "max_tokens": 100,
            "temperature": 0.8
        ]
        
        guard let url = URL(string: baseURL),
              let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            return generateFallbackPrompt(for: book)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("API request failed")
                return generateFallbackPrompt(for: book)
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let firstChoice = choices.first,
               let message = firstChoice["message"] as? [String: Any],
               let content = message["content"] as? String {
                return content.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } catch {
            print("Failed to generate AI prompt: \(error)")
        }
        
        return generateFallbackPrompt(for: book)
    }
    
    private func generateFallbackPrompt(for book: Book) -> String {
        let prompts = [
            "Remember \"\(book.title)\"? You left off at page \(book.currentPage). Time to find out what happens next!",
            "Your book is calling! \"\(book.title)\" is waiting for you at page \(book.currentPage).",
            "Take a break from scrolling and dive back into \"\(book.title)\" by \(book.author)!",
            "You're \(Int(book.progress * 100))% through \"\(book.title)\". Let's keep that momentum going!",
            "Trade your screen time for story time! \"\(book.title)\" awaits.",
            "Social media will still be here. Your book adventure in \"\(book.title)\" won't wait!",
            "Page \(book.currentPage) of \"\(book.title)\" is where you left the story. Ready to continue?",
            "Reading > Scrolling. Pick up \"\(book.title)\" and see what you've been missing!"
        ]
        
        return prompts.randomElement() ?? "Time to read \"\(book.title)\"!"
    }
    
    func updateAPIKey(_ key: String) {
        UserDefaults.standard.set(key, forKey: "openai_api_key")
    }
    
    func getAPIKey() -> String {
        return UserDefaults.standard.string(forKey: "openai_api_key") ?? ""
    }
}
