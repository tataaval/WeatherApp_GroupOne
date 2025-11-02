//
//  ChatInputView.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//

import UIKit

class ChatInputView: UIView {
    //MARK: - UI Componenets
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = .white
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.attributedPlaceholder = NSAttributedString(
            string: "Ask me a question about the weather",
            attributes: [.foregroundColor: UIColor(white: 1.0, alpha: 0.7)]
        )
        return textField
    }()

    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        let sendImage = UIImage(
            systemName: "paperplane.fill",
            withConfiguration: config
        )
        button.setImage(sendImage, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //MARK: - UI Componenets
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Setup Methods
    private func setupUI() {
        //TODO: asset-ებში არსებულით შეიცვალოს
        backgroundColor = UIColor(red: 98 / 255, green: 47 / 255, blue: 181 / 255, alpha: 1)
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 6

        setupTexfield()
        setupSendButton()
    }

    private func setupTexfield() {
        addSubview(textField)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 38),
        ])
    }

    private func setupSendButton() {
        addSubview(sendButton)
        NSLayoutConstraint.activate([
            sendButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            sendButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 40),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

}
