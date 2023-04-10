//
//  NotesRepoProtocol.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import Foundation

protocol NotesRepoProtocol: AnyObject {
    func getAllNotes() async -> Notes
    func saveNote(note: Note)
    func deleteNote(note: Note)
}
