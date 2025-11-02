//
//  CustomLabel.swift
//  weather
//
//  Created by Natali Zhgenti on 01.11.25.
//

import UIKit

class CustomLabel: UILabel {
    
    //MARK: - Private Properties
    private let labelFont: UIFont
    
    //MARK: - Init
    init(_ labelFont: UIFont, _ color: UIColor) {
        self.labelFont = labelFont
        super.init(frame: .zero)
        self.textColor = color
        self.font = labelFont
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
