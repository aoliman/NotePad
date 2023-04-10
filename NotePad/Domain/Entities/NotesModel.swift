//
//  NotePadModel.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import Foundation

struct Notes: Codable {
    let notePads: [Note]?
}

// MARK: - Lesson -

struct Note: Codable, Identifiable {
    public let id: UUID?
    public var note: String?
    public var date: Date?

}
