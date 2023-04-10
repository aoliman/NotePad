//
//  NotesListViewModel.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import SwiftUI
import Combine

public class NotesListViewModel : ObservableObject  {
    
    @Published var notes: [Note] =  []
    @Published var note:Note?
    @Published var noteText:String = "" {
        didSet{
            note?.note = noteText
        }
    }


    private let notePadOperation: NotePadOperation
    
    init(notePadOperation:NotePadOperation) {
        self.notePadOperation = notePadOperation
    }
    
}

extension NotesListViewModel {
    func loadNotes() async {
      let notes = await notePadOperation.loadNotes()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.notes = notes.notePads ?? []
        }
    }

    
    func saveNote(note:Note) {
        notePadOperation.saveNote(note: note)
    }
    
    func deleteNote(note:Note) {
        notePadOperation.deleteNote(note: note)
    }
    
    func shareNote(note:Note){
        notePadOperation.shareNote(note: note)
    }
    
    
    
}
