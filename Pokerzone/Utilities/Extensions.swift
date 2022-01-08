//
//  Extensions.swift
//  Pokerzone
//
//  Created by Esraa Gamal on 07/01/2022.
//

import Cocoa


extension NSView {
    func fillSuperView(_ superView: NSView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
    
    func setConstraints(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0, paddingBottom: CGFloat = 0, paddingLeading: CGFloat = 0, paddingTrailing: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func makeItCentered(centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, paddingX: CGFloat = 0, paddingY: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let xAnchor = centerX {
            centerXAnchor.constraint(equalTo: xAnchor, constant: paddingX).isActive = true
        }
        
        if let yAnchor = centerY {
            centerYAnchor.constraint(equalTo: yAnchor, constant: paddingY).isActive = true
        }
    }
}