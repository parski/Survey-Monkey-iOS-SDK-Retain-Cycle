//
//  RetainedViewController.swift
//  SurveyLeak
//
//  Created by Pär Strindevall on 2019-10-11.
//  Copyright © 2019 Plata o Plomo AB. All rights reserved.
//

import UIKit

protocol RetainedViewControllerDelegate : AnyObject {
    func didPressCloseButton(_ retainedViewController: RetainedViewController)
    func willDeInitialize(_ retainedViewController: RetainedViewController)
}

class RetainedViewController : UIViewController {
    
    static var retainedInstanceCount: Int = 0
    
    private let closeButton = UIButton(type: .system)
    private let surveyButton = UIButton(type: .system)
    
    weak var delegate: RetainedViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        RetainedViewController.retainedInstanceCount += 1
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    deinit {
        RetainedViewController.retainedInstanceCount -= 1
        delegate?.willDeInitialize(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        setUpViews()
    }
    
    private func setUpViews() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 32)
        ])
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(didPressCloseButton), for: .touchUpInside)
        
        surveyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(surveyButton)
        NSLayoutConstraint.activate([
            surveyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            surveyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        surveyButton.setTitle("Survey", for: .normal)
        surveyButton.setTitleColor(.black, for: .normal)
        surveyButton.addTarget(self, action: #selector(didPressSurveyButton), for: .touchUpInside)
    }
    
    @objc private func didPressCloseButton() {
        delegate?.didPressCloseButton(self)
    }
    
    @objc private func didPressSurveyButton() {
        let feedbackViewController = SMFeedbackViewController(survey: "LBQK27G")
        feedbackViewController?.present(from: self, animated: true, completion: { })
    }
}
