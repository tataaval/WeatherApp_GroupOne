//
//  AIAssistantViewModel.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//

import UIKit

//MARK: - Protocols
protocol AIAssistantViewModelType {
    var input: AIAssistantViewModelInput { get }
    var output: AIAssistantViewModelOutput? { get set }
}

protocol AIAssistantViewModelInput {
    func startSession(_ prompt: String)
    func resumeSession(_ prompt: String, id: String)
}

protocol AIAssistantViewModelOutput: AnyObject {
    func updateMessages(_ messages: [ChatItemModel])
}

//MARK: - AIAssistantViewModel
class AIAssistantViewModel: AIAssistantViewModelType {
    //MARK: - Public Properties
    var input: AIAssistantViewModelInput { self }
    weak var output: AIAssistantViewModelOutput?

    //MARK: - private Properties
    private var sessionID: String?
    private(set) var chatMessages: [ChatItemModel] = [] {
        didSet {
            output?.updateMessages(chatMessages)
        }
    }

    //MARK: - Calculated Properties
    var currentSessionID: String? { sessionID }
    var numberOfMessages: Int { chatMessages.count }

    //MARK: - Public Function
    func message(at index: Int) -> ChatItemModel {
        return chatMessages[index]
    }

    //MARK: - Private Helpers
    private func appendUserMessage(_ text: String) {
        chatMessages.append(ChatItemModel(text: text, isUserMessage: true))
    }
    
    private func appendThinkingMessage() -> Int {
        let placeholder = ChatItemModel(text: "დავფიქრდები, ან გიპასუხებ, ან ვერა...", isUserMessage: false, isLoading: true)
        chatMessages.append(placeholder)
        return chatMessages.count - 1
    }

    private func sendRequest(prompt: String, url: String) {
        let placeholderIndex = appendThinkingMessage()
        let body = AIAssistantRequestModel(prompt: prompt)

        NetworkService.shared.postData(baseURL: url, requestBody: body) {
            [weak self] (result: Result<AIAssistantResponseModel, Error>) in

            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.sessionID = response.session_id
                    self.chatMessages[placeholderIndex] = ChatItemModel(text: response.answer, isUserMessage: false)
                case .failure(let error):
                    self.chatMessages[placeholderIndex] = ChatItemModel(text: "Error occurred: \(error.localizedDescription)",isUserMessage: false)
                }
            }
        }
    }
}

//MARK: - AIAssistantViewModelInput
extension AIAssistantViewModel: AIAssistantViewModelInput {
    func startSession(_ prompt: String) {
        appendUserMessage(prompt)
        let endpoint = "https://api.openweathermap.org/assistant/session?units=metric"
        sendRequest(prompt: prompt, url: endpoint)
    }

    //TODO: endpoint-ები გავიტანოთ გარეთ!
    func resumeSession(_ prompt: String, id: String) {
        appendUserMessage(prompt)
        let sessionToUse = sessionID ?? id
        let endpoint = "https://api.openweathermap.org/assistant/session/\(sessionToUse)?units=metric"
        sendRequest(prompt: prompt, url: endpoint)
    }

}
