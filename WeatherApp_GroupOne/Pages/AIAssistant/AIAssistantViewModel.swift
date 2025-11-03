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

    private func appendAssistantMessage(_ text: String) {
        chatMessages.append(ChatItemModel(text: text, isUserMessage: false))
    }

    private func sendRequest(prompt: String, url: String) {
        let body = AIAssistantRequestModel(prompt: prompt)

        NetworkService.shared.postData(baseURL: url, requestBody: body) {
            [weak self] (result: Result<AIAssistantResponseModel, Error>) in

            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.sessionID = response.session_id
                    self.appendAssistantMessage(response.answer)

                case .failure(let error):
                    self.handleError(error)
                }
            }
        }
    }

    private func handleError(_ error: Error) {
        print(error.localizedDescription)
        appendAssistantMessage("Error occured, \(error.localizedDescription)")
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
