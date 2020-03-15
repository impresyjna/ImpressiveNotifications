//
//  INNotification.swift
//  ImpressiveNotifications
//
//  Created by Asia Kasprzycka on 11/02/2019.
//  Copyright © 2019 Asia Kasprzycka. All rights reserved.
//

import UIKit

public class INNotification: UIView {
    var data: INNotificationData
    let titleLabel: UILabel = UILabel()
    let descriptionLabel: UILabel = UILabel()
    let iconImageView: UIImageView = UIImageView()
    let titleDescriptionStackView: UIStackView = UIStackView()
    var timer: Timer?
    let position: INNotificationPosition
    
    var cornerRadius: CGFloat = 6.0
    var verticalMargin: CGFloat = 16.0
    var imageSize: CGSize = CGSize(width: 48, height: 48)
    
    lazy var viewsDict = ["titleLabel": titleLabel,
                          "descriptionLabel": descriptionLabel,
                          "iconImageView": iconImageView,
                          "titleDescriptionStack": titleDescriptionStackView]
    
    var viewConstraints: [NSLayoutConstraint] = []
    let type: INNotificationType
    let customStyle: INNotificationStyle?
    
    required public init?(coder aDecoder:NSCoder) {
        fatalError("Not implemented.")
    }
    
    public init(with data: INNotificationData = INNotificationData(), type: INNotificationType, customStyle: INNotificationStyle? = nil, position: INNotificationPosition) {
        self.data = data
        self.type = type
        self.customStyle = customStyle
        self.position = position
        
        super.init(frame: CGRect.zero)
        
        setupView()
        setupGestures()
    }
    
    private func setupConstraints() {
        self.addSubview(iconImageView)
        self.addSubview(titleDescriptionStackView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        setupImageView()
        setupStackView()
        setupTitleDescriptionLabel()
        
        NSLayoutConstraint.activate(viewConstraints)
        
        self.sizeToFit()
    }
    
    private func setupImageView() {
        viewConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[iconImageView(\(imageSize.width))]-16-[titleDescriptionStack]-16-|", options: [], metrics: nil, views: viewsDict)
        viewConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-16@750-[iconImageView(\(imageSize.height))]", options: [], metrics: nil, views: viewsDict)
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        setupImage()
        
        if let image = data.image {
            iconImageView.image = image
        }
    }
    
    private func setupImage() {
        iconImageView.contentMode = .center
        
        switch type {
        case .success:
            iconImageView.image = "✅".image(size: imageSize)
        case .warning:
            iconImageView.image = "⚠️".image(size: imageSize)
        case .danger:
            iconImageView.image = "❌".image(size: imageSize)
        case .custom:
            break
        }
    }
    
    private func setupStackView() {
        titleDescriptionStackView.axis = NSLayoutConstraint.Axis.vertical
        titleDescriptionStackView.distribution = UIStackView.Distribution.fill
        titleDescriptionStackView.alignment = UIStackView.Alignment.leading
        titleDescriptionStackView.spacing = 8.0
        
        titleDescriptionStackView.addArrangedSubview(titleLabel)
        titleDescriptionStackView.addArrangedSubview(descriptionLabel)
        
        viewConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[titleDescriptionStack(>=iconImageView)]-16-|", options: [], metrics: nil, views: viewsDict)
        
        titleDescriptionStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTitleDescriptionLabel() {
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 250.0), for: .vertical)
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251.0), for: .vertical)
        
        titleLabel.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.medium)
        descriptionLabel.font = UIFont.systemFont(ofSize: 15.0)
    }
    
    private func setupView() {
        self.backgroundColor = .white
        
        setupCustomStyle()
        
        switch type {
        case .custom(let view):
            self.backgroundColor = .clear
            setupCustomView(view: view)
        case .danger, .success, .warning:
            setupNormalView()
        }
        
        setupShadow()
    }
    
    private func setupNormalView() {
        self.layer.cornerRadius = cornerRadius
        
        setupConstraints()
    }
    
    private func setupShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
    }
    
    private func setupCustomView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        
        view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        
        self.sizeToFit()
        self.layoutIfNeeded()
    }
    
    private func setupCustomStyle() {
        guard let customStyle = customStyle else {
            return
        }
        
        self.cornerRadius = customStyle.cornerRadius ?? self.cornerRadius
        self.backgroundColor = customStyle.backgroundColor ?? .white
        self.titleLabel.textColor = customStyle.titleColor ?? .black
        self.descriptionLabel.textColor = customStyle.descriptionColor ?? .black
        self.imageSize = customStyle.imageSize ?? self.imageSize
    }
    
    private func setupGestures() {
        NotificationCenter.default.addObserver(self, selector: #selector(rotateView), name: UIDevice.orientationDidChangeNotification, object: nil)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedNotification))
        addGestureRecognizer(tapRecognizer)
        
        switch position {
        case .top:
            let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(hideUp))
            swipeRecognizer.direction = .up
            addGestureRecognizer(swipeRecognizer)
        case .bottom:
            let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(hideDown))
            swipeRecognizer.direction = .down
            addGestureRecognizer(swipeRecognizer)
        }
        
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(hideLeft))
        leftSwipeRecognizer.direction = .left
        addGestureRecognizer(leftSwipeRecognizer)
        
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(hideRight))
        rightSwipeRecognizer.direction = .right
        addGestureRecognizer(rightSwipeRecognizer)
    }
    
    @objc internal func rotateView() {
        UIView.animate(withDuration: 0.2) {
            self.center.x = UIScreen.main.bounds.width / 2
            self.center.y = self.safeAreaInsets.top + self.verticalMargin + self.frame.height / 2
        }
    }
    
    @objc func hideUp() {
        hideNotification(direction: .top)
    }
    
    @objc func hideDown() {
        hideNotification(direction: .bottom)
    }
    
    @objc func hideRight() {
        hideNotification(direction: .right)
    }
    
    @objc func hideLeft() {
        hideNotification(direction: .left)
    }
    
    internal func hideNotification(direction: INNotificationHideDirection) {
        let translate: CGAffineTransform
        switch direction {
        case .top:
            translate = CGAffineTransform(translationX: 0, y: (-self.frame.height - 100))
        case .bottom:
            translate = CGAffineTransform(translationX: 0, y: self.frame.height + 100)
        case .left:
            translate = CGAffineTransform(translationX: (-self.frame.width - 100), y: 0)
        case .right:
            translate = CGAffineTransform(translationX: self.frame.width + 100, y: 0)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = translate
        }, completion: { [weak self] (complete: Bool) in
            self?.removeFromSuperview()
        })
    }
    
    @objc internal func finishNotification() {
        hideNotification(direction: position.hideDirection)
        data.parentDelegate?.impressiveNotificationFinished()
    }
    
    @objc internal func tappedNotification() {
        data.completionHandler?()
        data.parentDelegate?.impressiveNotificationTapped()
        
        guard data.hideOnTap else { 
            return 
        }
        
        hideNotification(direction: position.hideDirection)
        
        timer?.invalidate()
        timer = nil
    }
    
    public func hide() {
        timer?.invalidate()
        timer = nil
        
        finishNotification()
    }
    
    public func showNotification() {
        if let delay = data.delay {
            timer = Timer.scheduledTimer(timeInterval: Double(delay), target: self, selector: #selector(finishNotification), userInfo: nil, repeats: false)
        }
        
        let newY: CGFloat
        switch position {
        case .top:
            newY = self.safeAreaInsets.top + self.verticalMargin
        case .bottom:
            newY = self.safeAreaInsets.bottom - self.verticalMargin - self.frame.height
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.68, initialSpringVelocity: 0.1, options: UIView.AnimationOptions(), animations: {
            self.frame.origin.y = newY
        })
    }
}
