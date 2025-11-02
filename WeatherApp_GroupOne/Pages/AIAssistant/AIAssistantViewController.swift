//
//  AIAssistantViewController.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//


import UIKit

class AIAssistantViewController: UIViewController {
    
    //MARK: - test data
    
    private let chatMessages: [ChatItemModel] = [
        ChatItemModel(text: "რამე კაი მითხარი", isUserMessage: true),
        ChatItemModel(text: "ახლა რა გინდა ორმ გითხრა მე", isUserMessage: false),
        ChatItemModel(text: "რავი რავა ვართ მაგალითად", isUserMessage: true),
        ChatItemModel(text: "უკეთესადაც ვყოფილვართ... lorem ipsum dolor sit amet, consectetur adipiscing elit. orem ipsum dolor sit amet, consectetur adipiscing elit. orem ipsum dolor sit amet, consectetur adipiscing elit. ", isUserMessage: false),
    ]

    //MARK: - UI Components
    private let chatInputView: ChatInputView = ChatInputView()
    private let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage("background")
        setupUI()
        setupBindings()
    }
    
    //MARK: - Setup Functions
    private func setupUI() {
        setupChatInputView()
        setupTableView()
    }
    private func setupChatInputView() {
        view.addSubview(chatInputView)
        chatInputView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chatInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            chatInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            chatInputView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupTableView() {
        view.addSubview(chatTableView)
        
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: chatInputView.topAnchor, constant: -8)
        ])
    }
    
    private func setupBindings() {
        chatTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatTableViewCell")
        chatTableView.delegate = self
        chatTableView.dataSource = self
    }

}

extension AIAssistantViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        
        let messageItem = chatMessages[indexPath.row]
        cell.configure(with: messageItem)
        
        return cell
    }
}
