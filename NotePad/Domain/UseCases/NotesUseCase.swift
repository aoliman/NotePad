//
//  NotesUseCase.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import Foundation

protocol NotesUseCaseProtocol {
    func getAllNotes() async -> Notes
    func saveNote(note: Note)
    func deleteNote(note: Note)
}


class NotesUseCase {
    private let notesRepo: NotesRepoProtocol

    init(notesRepo: NotesRepoProtocol) {
        self.notesRepo = notesRepo
    }
}

extension NotesUseCase: NotesUseCaseProtocol {
    func getAllNotes() async -> Notes {
        await notesRepo.getAllNotes()
    }

    func saveNote(note: Note) {
        notesRepo.saveNote(note: note)
    }

    func deleteNote(note: Note) {
        notesRepo.deleteNote(note: note)
    }


}
