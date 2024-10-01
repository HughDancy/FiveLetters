//
//  Words.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import Foundation

struct Words: Decodable {
    let words: [String]
}

final class WordsCollection {
    private let decoder = JSONDecoder()
    private let fileName = "words"
    var collection: Words?

    init() {
        self.loadWords()
    }

    private func loadWords() {
        let bundle = Bundle.main
        let url = bundle.url(forResource: fileName, withExtension: "json")
        guard let fileUrl = url else { return }
        do {
            let data = try Data(contentsOf: fileUrl)
            self.collection = try decoder.decode(Words.self, from: data)
        } catch (let error) {
            print("Ошибка при декодировании файла по адресу: \(fileUrl), ошибка: \(error)")
        }
    }

    func getRandomWord() -> String {
        return self.collection?.words.randomElement() ?? "дождь"
    }
}
