//
//  BottomPopUpView.swift
//  BottomPopUpView
//
//  Created by Akbar on 6/9/20.
//  Copyright © 2020 Akbar. All rights reserved.
//

import UIKit

public class BottomPopUpView: UIViewController {
    
    public enum Dimension {
        public static var width: CGFloat = UIScreen.main.bounds.width
        public static var wrapperContentBottomOffset: CGFloat = 50
        public static var wrapperContentHeight: CGFloat = 400
        public static var actionButtonHeight: CGFloat = 52
        public static var wrapperViewCornerRadius: CGFloat = 30
        public static var tableViewBottomOffset: CGFloat = 20
        public static var dampingRatio: CGFloat = 0.7
    }
    
    public var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 72
        tableView.bounces = true
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.tableHeaderView?.backgroundColor = .white
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    var wrapperView: UIView = {
        let wrapperView = UIView(frame: CGRect.zero)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.backgroundColor = .white
        wrapperView.layer.cornerRadius = BottomPopUpView.Dimension.wrapperViewCornerRadius
        wrapperView.clipsToBounds = true
        return wrapperView
    }()
    
    lazy var backgroundView: UIView = {
        let bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.backgroundColor = UIColor.init(white: 0, alpha: 1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapBehind(_:)))
        bgView.addGestureRecognizer(tap)
        return bgView
    }()
    
    public var backgroundViewAlpha: CGFloat = 0.8
    public var shouldDismissOnDrag: Bool = true
    
    private var wrapperViewBottomAnchor: NSLayoutConstraint?
    
    private var isOpen: Bool? {
        didSet {
            if oldValue != isOpen {
                self.view.setNeedsUpdateConstraints()
                self.view.setNeedsLayout()
                let layoutAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: BottomPopUpView.Dimension.dampingRatio) {
                    self.view.layoutIfNeeded()
                }
                layoutAnimator.addCompletion { [weak self] _ in
                    if let isOpen = self?.isOpen, !isOpen {
                        self?.dismiss(animated: false, completion: nil)
                    }
                }
                layoutAnimator.startAnimation()
            }
        }
    }
    
    public init(wrapperContentHeight: CGFloat) {
        super.init(nibName: nil, bundle: nil)
        Dimension.wrapperContentHeight = wrapperContentHeight
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


extension BottomPopUpView {
    
    public override func updateViewConstraints() {
        super.updateViewConstraints()
        guard let isOpen = isOpen else { return }
        if isOpen {
            wrapperViewBottomAnchor?.constant = BottomPopUpView.Dimension.wrapperContentBottomOffset
        } else {
            wrapperViewBottomAnchor?.constant = BottomPopUpView.Dimension.wrapperContentHeight
        }
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let isOpen = isOpen {
            if isOpen {
                wrapperView.alpha = 1
                backgroundView.alpha = backgroundViewAlpha
            } else {
                wrapperView.alpha = 0
                backgroundView.alpha = 0
            }
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isOpen = true
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @objc func closeAction(sender: Any?) {
        self.dissmiss()
    }
    
    @objc func handleTapBehind(_ sender: Any?) {
        self.dissmiss()
    }
    
    private func dissmiss() {
        self.isOpen = false
    }
    
    private func setUp() {
        self.tableView.delegate = self
        
        self.modalPresentationStyle = .custom
        self.modalTransitionStyle = .crossDissolve
        
        self.view.backgroundColor = .clear
        
        self.view.addSubview(backgroundView)
        self.view.addSubview(wrapperView)
        self.wrapperView.addSubview(tableView)
        
        self.addLayouts()
        
    }
    
    private func addLayouts() {
        // backgroundView Constraints
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // wrapper Constraints
        wrapperView.heightAnchor.constraint(equalToConstant: BottomPopUpView.Dimension.wrapperContentHeight).isActive = true
        wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        wrapperViewBottomAnchor = wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: BottomPopUpView.Dimension.wrapperContentHeight)
        wrapperViewBottomAnchor?.isActive = true
        
        // tableView Constraints
        tableView.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -BottomPopUpView.Dimension.wrapperContentBottomOffset - BottomPopUpView.Dimension.tableViewBottomOffset).isActive = true
        
        self.view.layoutIfNeeded()
    }
}

extension BottomPopUpView: UIScrollViewDelegate, UITableViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (tableView.contentOffset.y < 0) && shouldDismissOnDrag
        {
            self.dissmiss()
        }
    }
}
