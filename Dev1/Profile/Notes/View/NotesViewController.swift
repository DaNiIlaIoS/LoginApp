//
//  NotesViewController.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 03.08.2024.
//

import UIKit

protocol NotesViewProtocol: AnyObject {
    var presenter: NotesPresenterProtocol! { get }
    func updateNotes()
}

final class NotesViewController: UIViewController, NotesViewProtocol {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var presenter: NotesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addButtonAction))
        view.addSubview(tableView)
        presenter = NotesPresenter(view: self)
    }
    
    func updateNotes() {
        tableView.reloadData()
    }
    
    @objc func addButtonAction() {
        createAlertController()
    }
    
    func createAlertController() {
        let alertController = UIAlertController(title: "New note", message: "Add new note", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "note"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let text = alertController.textFields?[0].text, !text.isEmpty else { return }
            self?.presenter.createNote(text: text)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let note = presenter.notes[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = note.text
        config.secondaryText = "\(note.date!)"
        config.image = note.isActive ? UIImage(systemName: "checkmark") : nil
        
        cell.contentConfiguration = config
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = presenter.notes[indexPath.row]
        let isActive = !note.isActive
        
        presenter.updateNoteIsActive(noteId: note.id, isActive: isActive)
    }
}
