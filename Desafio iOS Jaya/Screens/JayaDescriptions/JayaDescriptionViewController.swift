//
//  JayaDescriptionViewController.swift
//  Desafio iOS Jaya
//
//  Created by Ezequias Santos on 06/11/22.
//

import UIKit
import Kingfisher

final class JayaDescriptionViewController: UIViewController {
    
    // MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        iv.setDimension(width: 80, height: 80)
        iv.layer.cornerRadius = 80 / 2
        
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var githubButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ir para GitHub", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(showGit), for: .touchUpInside)
        return button
    }()
    
    private var viewModel: JayaDescriptionViewModelProtocol
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private var stack = UIStackView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstaints()
        view.backgroundColor = .white
    }
    
    init(viewModel: JayaDescriptionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func setup() {
        self.titleLabel.text = viewModel.issueArray.value?.title
        self.dateLabel.text = viewModel.issueArray.value?.date?.formatDateToPtBr()
        self.descriptionLabel.text = viewModel.issueArray.value?.body
        let imageUrl = viewModel.issueArray.value?.user?.avatar ?? ""
        DispatchQueue.main.async {
            let url = URL(string: imageUrl)
            let processor = DownsamplingImageProcessor(size: self.profileImageView.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 0)
            self.profileImageView.kf.indicatorType = .activity
            self.profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage(),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ]
            )
        }
    }
    
    func setupUI() {
        view.addSubview(scrollView)
        
        stack = UIStackView(
            arrangedSubviews: [
                profileImageView,
                titleLabel,
                dateLabel,
                descriptionLabel
            ]
        )
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 16
        scrollView.addSubview(stack)
        
        view.addSubview(githubButton)
    }
    
    func setupConstaints() {
        scrollView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor
        )
        
        stack.anchor(
            top: scrollView.topAnchor,
            paddingTop: 16 ,
            left: view.leftAnchor,
            paddingLeft: 16,
            bottom: scrollView.bottomAnchor,
            paddingBottom: 16,
            right: view.rightAnchor,
            paddingRight: 16
        )
        
        
        githubButton.anchor(
            top: scrollView.bottomAnchor,
            paddingTop: 16,
            left: view.leftAnchor,
            paddingLeft: 40,
            bottom: view.bottomAnchor,
            paddingBottom: 32,
            right: view.rightAnchor,
            paddingRight: 40
        )
    }
    
    // MARK: - Selectors
    
    @objc private func showGit() {
    if let url = URL(string: viewModel.issueArray.value?.url ?? "") {
        print(url)
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - String

extension String {
    func formatDateToPtBr() -> String {
        if self.count > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: self)
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return  dateFormatter.string(from: date!)
        } else {
            return "-"
        }
    }
}
