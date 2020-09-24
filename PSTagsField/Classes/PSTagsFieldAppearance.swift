//
//  PSTagsFieldAppearance.swift
//  Pods-PSTagsField_Example
//
//  Created by YSVGanesh on 08/06/20.
//

import Foundation

public struct PSTagsFieldAppearance {
    
    /// Font for title label
    public var titleFont = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    /// Font for text field
    public var textFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    
    /// Title label text color
    public var titleColor = UIColor(white: 1.0, alpha: 0.6)
    
    /// TextField text color
    public var textColor = UIColor.white
  
    /// TextField text color
    public var tagColor = UIColor(red: 165.0 / 255.0, green: 204.0 / 255.0, blue: 1, alpha: 1)
  
    //When title label becomes placeHolder
    public var placeHolderColor: UIColor = UIColor(white: 1.0, alpha: 0.8)
    
    /// Title label text uppercased
    public var uppercasedTitles = false
    
    /// Enable alert
    public var alertEnabled = true
    
    /// Font for alert label
    public var alertFont = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    /// Alert status color
    public var alertColor = UIColor.red
    
    /// VisualEffectView attributes
    public var visualEffectColorTint = UIColor.white
    public var visualEffectColorTintAlpha: CGFloat = 0.15
    public var visualEffectBlurRadius: CGFloat = 10
    public var visualEffectScale: CGFloat = 1
  
    public init() {}
}

