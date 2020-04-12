//
//  SelectionOptionsView.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 12/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
    }
}

class SelectionOptionsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 5.0
        addShadow()
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 24.0
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        
        let startSpacer = UIView(frame: .zero)
        
        let label1 = label(for: "Copy")
        let label2 = label(for: "Share")
        let label3 = label(for: "Respond")
        let label4 = label(for: "Define")
        
        let endSpacer = UIView(frame: .zero)
        
        stackView.addArrangedSubview(startSpacer)
        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(label2)
        stackView.addArrangedSubview(label3)
        stackView.addArrangedSubview(label4)
        stackView.addArrangedSubview(endSpacer)
        
        addSubview(stackView)
        stackView.pinToEdges(on: self)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func label(for text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 15.0)
        label.text = text
        label.textAlignment = .center
        return label
    }
}
