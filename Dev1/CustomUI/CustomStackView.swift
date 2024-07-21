//
//  CustomStackView.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 20.07.2024.
//

import UIKit

final class CustomStackView {
    static func createVerticalStack(distribution: UIStackView.Distribution, spacing: CGFloat = 15) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = distribution
        stackView.alignment = .fill
        stackView.spacing = spacing
        return stackView
    }
    
    static func createHorizontalStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }
}
