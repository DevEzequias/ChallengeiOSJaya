//
//  JayaViewController.swift
//  Desafio iOS Jaya
//
//  Created by Ezequias Santos on 04/11/22.
//

import UIKit

class JayaViewController: UIViewController {
    
    // MARK: - Properties
    
    let reuseIdentifier = "JayaTableViewCell"
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private var viewModel: JayaViewModelProtocol
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setuBinding()
    }
    
    init(viewModel: JayaViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setuBinding() {
        viewModel.issueArray.bind { [weak self] issues in
            guard let self = self else {return}
            if !issues.isEmpty {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupView() {
        title = "Issue"
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JayaTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            paddingTop: 16,
            left: view.leftAnchor,
            paddingLeft: 16,
            bottom:view.bottomAnchor,
            paddingBottom: 16,
            right: view.rightAnchor,
            paddingRight: 16
        )
    }
}

extension JayaViewController: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.issueArray.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! JayaTableViewCell
        cell.titleDescriptionLabel.text = viewModel.issueArray.value[indexPath.row].title
        cell.stateDescriptionLabel.text = viewModel.issueArray.value[indexPath.row].state
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8
        
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 4
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(
            x: cell.bounds.origin.x,
            y: cell.bounds.origin.y,
            width: cell.bounds.width,
            height: cell.bounds.height
        ).insetBy(
            dx: 0,
            dy: verticalPadding/2
        )
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = JayaDescriptionViewModel(object: viewModel.issueArray.value[indexPath.row])
        let controller = JayaDescriptionViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}


