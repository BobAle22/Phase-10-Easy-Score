//
//  NSLayoutConstraint+Extensions.swift
//  FireWorks Experiment
// 
//  Created by Robert J Alessi on 4/30/24.
//

import UIKit

extension NSLayoutConstraint {
    
    class func pin(view:UIView, to superview:UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor),
            view.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
