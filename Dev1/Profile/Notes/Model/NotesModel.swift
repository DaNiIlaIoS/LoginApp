//
//  NotesModel.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 03.08.2024.
//

import Foundation
import Firebase

struct Note {
    let id: String
    let text: String?
    let date: Date?
    let isActive: Bool
}

final class NotesModel {
    
    func createNote(text: String) {
        let noteData: [String: Any] = ["note": text,
                                       "date": Date(),
                                       "isActive": false]
        
        Firestore.firestore()
            .collection("users")
            .document(AppModel.userId)
            .collection("notes")
            .addDocument(data: noteData)
    }
    
    func getNotes(completion: @escaping ([Note]) -> ()) {
        Firestore.firestore()
            .collection("users")
            .document(AppModel.userId)
            .collection("notes")
            .order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                var notes: [Note] = []
                
                if let documents = snapshot?.documents {
                    documents.forEach { document in
                        let id = document.documentID
                        let note = document["note"] as? String
                        let timestamp = document["date"] as? Timestamp
                        let date = timestamp?.dateValue()
                        let isActive = document["isActive"] as! Bool
                        
                        let oneNote = Note(id: id, text: note, date: date, isActive: isActive)
                        notes.append(oneNote)
                    }
                }
                completion(notes)
            }
    }
    
    func updateNoteIsActive(noteId: String, isActive: Bool) {
        Firestore.firestore()
            .collection("users")
            .document(AppModel.userId)
            .collection("notes")
            .document(noteId)
            .updateData(["isActive": isActive]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
    }
}
