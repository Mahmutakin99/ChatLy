//
//  NewMessageViewController.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 04/08/2025.
//

import UIKit

private let reuseIdentifier = "UserCell"

protocol NewMessageViewControllerProtocol: AnyObject {
    func goToChatView(user: User)
}

class NewMessageViewController: UIViewController {
    
    //MARK: Properties
    weak var delegate: NewMessageViewControllerProtocol?
    private let tableView = UITableView()
    private var users = [User]()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        hideKeyboardWhenTappedAroundTable()
        tableView.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
}

//MARK: Helpers
extension NewMessageViewController {
    
    private func style() {
        //tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 75
        tableView.backgroundColor = .systemBlue.withAlphaComponent(0.7)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = true
    }
    
    private func layout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func hideKeyboardWhenTappedAroundTable() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: UITableViewDelegate/UITableViewDataSource
extension NewMessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        cell.backgroundColor = .systemGreen.withAlphaComponent(0.7)
        cell.selectionStyle = .default
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.goToChatView(user: users[indexPath.row])
    }
}
