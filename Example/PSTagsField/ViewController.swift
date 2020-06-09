//
//  ViewController.swift
//  PSTagsField
//
//  Created by Siva on 06/08/2020.
//  Copyright (c) 2020 Siva. All rights reserved.
//

import UIKit
import PSTagsField

class ViewController: UIViewController {

  @IBOutlet weak var tagsField: PSTagsField!
  @IBOutlet weak var tagsFieldHeightConstraint: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var appearance = PSTagsFieldAppearance()
    appearance.titleFont = UIFont(name: "AvenirNext-Regular", size: 14)!
    appearance.textFont = UIFont(name: "AvenirNext-Regular", size: 14)!
    
    //format.uppercasedTitles = true
    appearance.alertColor = .red
    appearance.alertFont = UIFont(name: "AvenirNext-Regular", size: 14)!
    
    tagsField.setUp(with: appearance, placeHolder: "User Tags")
    tagsField.targetTitleLeadingPadding = 10
    
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    
    
    /*tagsField.onDidAddTag = { [unowned self] _, _ in
      
      
    }
    
    tagsField.onDidRemoveTag = { [unowned self] _, _ in
      
    }*/
    
    tagsField.onDidChangeHeightTo = { [unowned self] height in
      if self.tagsField.tagsField.tags.isEmpty {
        self.tagsFieldHeightConstraint?.constant = 55
      }else {
        self.tagsFieldHeightConstraint?.constant = height + 20.0
      }
    }
    
//    tagsField.tagsField.onShouldAcceptTag = { field in
//      return false
//    }
  }
    
  @objc func handleTap() {
    tagsField.tagsField.endEditing()
    tagsField.tagsField.unselectAllTagViewsAnimated()
  }
}
