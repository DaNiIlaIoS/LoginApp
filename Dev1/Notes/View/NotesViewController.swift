//
//  NotesViewController.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 03.08.2024.
//

import UIKit

final class NotesViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .insetGrouped)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addButtonAction))
        view.addSubview(tableView)
    }
    
    @objc func addButtonAction() {
        createAlertController()
    }
    
    func createAlertController() {
        let alertController = UIAlertController(title: "New note", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "note"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let text = alertController.textFields?[0].text
        }
        alertController.addAction(saveAction)
        present(alertController, animated: true)
    }
}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var config = cell.defaultContentConfiguration()
        config.text = "Cell №\(indexPath.row)"
        
        cell.contentConfiguration = config
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
