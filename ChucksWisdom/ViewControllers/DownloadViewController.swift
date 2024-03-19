//
//  DownloadViewController.swift
//  ChucksWisdom
//
//  Created by Apple Mac Air on 15.03.2024.
//

import UIKit

final class DownloadViewController: UIViewController {
    
    private let networkService = NetworkService()
    private lazy var realmService = RealmService()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Загрузить", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(downloadJoke), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(downloadButton)
        
        NSLayoutConstraint.activate([
           
            downloadButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            downloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            downloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            downloadButton.heightAnchor.constraint(equalToConstant: 50),
            
            label.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 40),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func downloadJoke () {
        networkService.requestValue { [weak self] joke, categories in
            DispatchQueue.main.async {
                self?.label.text = joke
                if categories.isEmpty {
                    self?.realmService.addJokeToList(joke: joke, category: "no category")
                    print("no category")
                } else {
                    for category in categories {
                        self?.realmService.addJokeToList(joke: joke, category: category)
                        print (category)
                    }
                }
            }
        }
    }
}
