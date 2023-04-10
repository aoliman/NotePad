//
//  NotePadOperation.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import Foundation

class NotePadOperation {
    private let notesUseCase: NotesUseCaseProtocol
    
    init(notesUseCase: NotesUseCaseProtocol) {
        self.notesUseCase = notesUseCase
    }
    
    func loadNotes() async -> Notes {
        await notesUseCase.getAllNotes()
    }
    
    func saveNote(note:Note) {
        notesUseCase.saveNote(note: note)
    }
    
    func deleteNote(note:Note) {
        notesUseCase.deleteNote(note: note)
    }
    
    func shareNote(note:Note){
        guard let shareMessage = note.note else {
            return
        }
        ShareAppHandler.share(data: shareMessage)
    }
    
}
