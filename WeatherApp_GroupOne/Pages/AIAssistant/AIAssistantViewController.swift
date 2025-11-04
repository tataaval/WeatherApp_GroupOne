//
//  AIAssistantViewController.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//


import UIKit

class AIAssistantViewController: UIViewController {
    
    //MARK: - Stored Property
    private let viewModel: AIAssistantViewModel

    //MARK: - UI Components
    private let chatInputView: ChatInputView = ChatInputView()
    private let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Init
    init(viewModel: AIAssistantViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setBackgroundImage()
        setupUI()
        setupBindings()
        
        chatInputView.delegate = self
        viewModel.output = self
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
        viewModel.numberOfMessages
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        
        let messageItem = viewModel.message(at: indexPath.row)
        cell.configure(with: messageItem)
        
        return cell
    }
}


extension AIAssistantViewController: ChatInputViewDelegate {
    func messageSent(_ message: String) {
        if let sessionID = viewModel.currentSessionID {
            viewModel.input.resumeSession(message, id: sessionID)
        } else {
            viewModel.input.startSession(message)
        }
    }
}


extension AIAssistantViewController: AIAssistantViewModelOutput {
    func updateMessages(_ messages: [ChatItemModel]) {
        let currentRows = chatTableView.numberOfRows(inSection: 0)
        let newRows = messages.count

        if newRows > currentRows {
            let indexPath = IndexPath(row: newRows - 1, section: 0)
            chatTableView.insertRows(at: [indexPath], with: .left)
            chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        } else {
            let indexPath = IndexPath(row: newRows - 1, section: 0)
            chatTableView.reloadRows(at: [indexPath], with: .fade)
            chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}
