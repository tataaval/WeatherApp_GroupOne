//
//  ChatTableViewCell.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    //MARK: - Ui Components
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let wrapperView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Methods
    private func setupUI() {
        setupWrapperView()
        setupMessageLabel()
        contentView.addSubview(wrapperView)
        wrapperView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            wrapperView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            messageLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12)
        ])
    }
    
    private func setupWrapperView() {
        contentView.addSubview(wrapperView)
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            wrapperView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupMessageLabel() {
        wrapperView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12)
        ])
    }
    
    
    //MARK: - Configure
    func configure(with message: ChatItemModel) {
        messageLabel.text = message.text
        //TODO: asset-ებში არსებულით ფერით შეიცვალოს
        wrapperView.backgroundColor = message.isUserMessage ? UIColor(red: 98 / 255, green: 47 / 255, blue: 181 / 255, alpha: 1) : UIColor(red: 98 / 255, green: 47 / 255, blue: 181 / 255, alpha: 0.3)
    }
    
}
