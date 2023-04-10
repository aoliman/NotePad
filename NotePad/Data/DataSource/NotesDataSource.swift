//
//  NotesDataSource.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import Foundation
import CoreData

protocol NotesDataSourceProtocol {
    func getAllNotesFromStrorage() async  -> Notes
    func saveNoteInStrorage(note:Note)
    func deleteNoteFromStrorage(note: Note)
}


class NotesDataSource  {
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
}

extension NotesDataSource : NotesDataSourceProtocol {
    
    func getAllNotesFromStrorage() async -> Notes {
        await withUnsafeContinuation { continuation in
            coreDataStorage.performBackgroundTask { context in
                let fetchRequest = NoteCoreData.fetchRequest()
                do {
                    let requestEntity =  try context.fetch(fetchRequest)
                    let coreDataDTO = NoteCoreData.toNoteDTO(requestEntity)
                    continuation.resume(returning: coreDataDTO)
                } catch {
                    continuation.resume(returning: Notes(notePads: []))
                }
            }
        }
    }
    
    func saveNoteInStrorage(note:Note) {
        if let id = note.id , let notetext = note.note {
            coreDataStorage.performBackgroundTask { context in
                let fetchRequest = NoteCoreData.fetchRequest()
                do {
                    let requestEntity =  try context.fetch(fetchRequest)
                    if let note = requestEntity.first(where: {$0.id == id}) {
                        note.note = notetext
                        try context.save()
                    }else if let _ = note.toCoreNoteEntityForInserting(context: context) {
                        do {
                            try context.save()
                        } catch {
                            ///Error
                        }
                    }
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    func deleteNoteFromStrorage(note: Note) {
        if let id = note.id  {
            coreDataStorage.performBackgroundTask { context in
                let fetchRequest = NoteCoreData.fetchRequest()
                do {
                    let requestEntity =  try context.fetch(fetchRequest)
                    if let note = requestEntity.first(where: {$0.id == id}) {
                        context.delete(note)
                        try context.save()
                    }
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    
}
