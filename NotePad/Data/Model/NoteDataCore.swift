//
//  NoteDataCore.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import Foundation
import CoreData

extension NoteCoreData {

    @objc public class func saveNoteObject(context: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: "NoteCoreData", into: context)
    }


    static func toNoteDTO(_ noteDataCore: [NoteCoreData]) -> Notes {
        var dtos = [Note]()
        for note in noteDataCore {
            let dto = Note(id: note.id,
                    note: note.note,
                    date: note.date)

            dtos.append(dto)
        }
        return Notes(notePads: dtos)

    }
}


extension Note {
    func toCoreNoteEntityForInserting(context: NSManagedObjectContext) -> NoteCoreData? {
        if let noteDataCore = NoteCoreData.saveNoteObject(context: context) as? NoteCoreData {
            noteDataCore.id = self.id
            noteDataCore.note = self.note
            noteDataCore.date = self.date

            return noteDataCore
        }
        return nil
    }
}

