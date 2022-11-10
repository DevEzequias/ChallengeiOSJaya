//
//  JayaTableViewCell.swift
//  Desafio iOS Jaya
//
//  Created by Ezequias Santos on 05/11/22.
//

import UIKit

class JayaTableViewCell: UITableViewCell {
    
    // MARK: - Properties

 static let indetifier = "JayaTableViewCell"
    
    let titleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Projeto Foda!"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    private let stateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "State: "
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    let stateDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Aberto"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    private var stackTitle = UIStackView()
    private var stackState = UIStackView()
    private var stackContainer = UIStackView()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.setHeight(height: 1)
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIndentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIndentifier)
        custonCell()
        setupConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func custonCell() {
        layer.cornerRadius = 6
        
        stackTitle = UIStackView(arrangedSubviews: [titleDescriptionLabel])
        stackTitle.axis = .horizontal
        stackTitle.alignment = .leading
        stackTitle.spacing = 5

        stackState = UIStackView(arrangedSubviews: [stateLabel, stateDescriptionLabel])
        stackState.axis = .horizontal
        stackState.alignment = .leading
        stackState.spacing = 5

        stackContainer = UIStackView(arrangedSubviews: [stackTitle, stackState])
        stackContainer.axis = .vertical
        stackContainer.alignment = .leading
        stackContainer.spacing = 5

        addSubview(stackContainer)
        addSubview(dividerView)
    }

    private func setupConstraint() {
        stackContainer.anchor(
            top: topAnchor,
            paddingTop: 5,
            left: leftAnchor,
            paddingLeft: 5,
            right: rightAnchor,
            paddingRight: 5
        )
        
        dividerView.anchor(
            top: stackContainer.bottomAnchor,
            paddingTop: 5,
            left: leftAnchor,
            paddingLeft: 5,
            bottom: bottomAnchor,
            paddingBottom: 5,
            right: rightAnchor,
            paddingRight: 5
        )
    }
    
}
