//
//  NotesPresenter.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 03.08.2024.
//

import Foundation

protocol NotesPresenterProtocol: AnyObject {
    var notes: [Note] { get }
    func createNote(text: String)
    func updateNoteIsActive(noteId: String, isActive: Bool)
}

final class NotesPresenter: NotesPresenterProtocol {
    private let notesModel = NotesModel()
    private weak var view: NotesViewProtocol?
    var notes: [Note] = []
    
    init(view: NotesViewProtocol?) {
        self.view = view
        getNotes()
    }
    
    func createNote(text: String) {
        notesModel.createNote(text: text)
    }
    
    func getNotes() {
        notesModel.getNotes { [weak self] notes in
            print(notes)
            self?.notes = notes
            self?.view?.updateNotes()
        }
    }
    
    func updateNoteIsActive(noteId: String, isActive: Bool) {
        notesModel.updateNoteIsActive(noteId: noteId, isActive: isActive) 
    }
}
