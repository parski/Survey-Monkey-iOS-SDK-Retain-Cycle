//
//  ViewController.swift
//  SurveyLeak
//
//  Created by Pär Strindevall on 2019-10-11.
//  Copyright © 2019 Plata o Plomo AB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let countLabel = UILabel(frame: .zero)
    private let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countLabel.text = "Retained: \(RetainedViewController.retainedInstanceCount)"
    }

    private func setUpViews() {
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(countLabel)
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        countLabel.text = "Retained: \(RetainedViewController.retainedInstanceCount)"
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 32)
        ])
        button.setTitle("Present RetainedViewController", for: .normal)
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
    }
    
    @objc private func didPressButton() {
        let retainedViewController = RetainedViewController()
        retainedViewController.delegate = self
        present(retainedViewController, animated: true)
    }
}

extension ViewController : RetainedViewControllerDelegate {
    
    func didPressCloseButton(_ retainedViewController: RetainedViewController) {
        retainedViewController.dismiss(animated: true)
    }
    
    func willDeInitialize(_ retainedViewController: RetainedViewController) {
        countLabel.text = "Retained: \(RetainedViewController.retainedInstanceCount)"
    }
}
