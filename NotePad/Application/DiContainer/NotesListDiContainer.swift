//
//  NotepadListDiContainer.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import Foundation

final class NotesListDiContainer {

    private static var notesDataSource: NotesDataSource = NotesDataSource()
    public static var notesListViewModel: NotesListViewModel = makeNotesListViewModel()


    static func makeNotesRepository() -> NotesRepository {
        NotesRepository(notesSrc: notesDataSource)
    }

    static func makeNotesUseCase() -> NotesUseCase {
        NotesUseCase(notesRepo: makeNotesRepository())
    }

    static func makeNotePadOperation() -> NotePadOperation {
        NotePadOperation(notesUseCase: makeNotesUseCase())
    }

    static func makeNotesListViewModel() -> NotesListViewModel {
        NotesListViewModel(notePadOperation: makeNotePadOperation())
    }


}
