//
//  CustomLabel.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 20.07.2024.
//

import UIKit

final class CustomLabel {
    
    static func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.text = text
        label.textAlignment = .center
        label.textColor = .white
        return label
    }
    
    static func createSubtitle(text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.text = text
        label.textAlignment = .center
        label.textColor = .gray
//        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }
}
