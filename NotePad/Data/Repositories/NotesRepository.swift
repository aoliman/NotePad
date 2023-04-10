//
//  NotesRepository.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import Foundation

class NotesRepository {

    private let notesSrc: NotesDataSourceProtocol

    init(notesSrc: NotesDataSourceProtocol) {
        self.notesSrc = notesSrc
    }

}

extension NotesRepository: NotesRepoProtocol {

    func getAllNotes() async -> Notes {
        await notesSrc.getAllNotesFromStrorage()
    }

    func saveNote(note: Note) {
        notesSrc.saveNoteInStrorage(note: note)
    }

    func deleteNote(note: Note) {
        notesSrc.deleteNoteFromStrorage(note: note)
    }

}

