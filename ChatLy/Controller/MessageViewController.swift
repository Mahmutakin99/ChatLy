//
//  MessageViewController.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 04/08/2025.
//

import UIKit
import FirebaseFirestore

private let reuseIdentifier = "MessageCell"

protocol MessageViewControllerProtocol: AnyObject {
    func showChatViewController(_ messageViewController: MessageViewController, user: User)
}

class MessageViewController: UIViewController {
    
    // MARK: Properties
    weak var delegate: MessageViewControllerProtocol?
    private var lastUsers = [LastUser]()
    private let tableView = UITableView()
    private var lastUsersListener: ListenerRegistration?
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLastUsers()
        style()
        layout()
        hideKeyboardWhenTappedAroundTable()
        tableView.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLastUsers()
    }
    
    deinit { lastUsersListener?.remove() }
    
    // MARK: Service
    private func fetchLastUsers() {
        lastUsersListener?.remove()
        lastUsersListener = Service.fetchLastUsers { [weak self] lastUsers in
            guard let self = self else { return }
            self.lastUsers = lastUsers
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
}

// MARK: Helpers
extension MessageViewController {
    private func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.backgroundColor = .systemBlue.withAlphaComponent(0.7)
        //tableView.separatorStyle = .none
        tableView.register(MessageCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.allowsSelection = true
    }
    
    private func layout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
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

// MARK: UITableViewDelegate, UITableViewDataSource
extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lastUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.lastUser = lastUsers[indexPath.row]
        cell.backgroundColor = .systemGreen.withAlphaComponent(0.7)
        cell.selectionStyle = .default // Hücre seçim stilini varsayılan yap
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.showChatViewController(self, user: lastUsers[indexPath.row].user)
    }
}
