//
//  PSTagsField.swift
//  Pods-PSTagsField_Example
//
//  Created by YSVGanesh on 08/06/20.
//

import UIKit

open class PSTagsField: UIView {
  
  var appearance = PSTagsFieldAppearance() {
    didSet {
      titleLabel.font = appearance.titleFont
      titleLabel.textColor = appearance.titleColor
      alertLabel.font = appearance.alertFont
      tagsField.font = appearance.textFont
    }
  }
  
  /// Placeholder
  var placeholder = ""
  
  var isPlaceholderVisible = true
  
  public var targetTitleLeadingPadding: CGFloat = 10.0
  
  public let tagsField = WSTagsField()
  
  // MARK: - Events
  
  /// Called when a tag has been added. You should use this opportunity to update your local list of selected items.
  open var onDidAddTag: ((WSTagsField, _ tag: WSTag) -> Void)?

  /// Called when a tag has been removed. You should use this opportunity to update your local list of selected items.
  open var onDidRemoveTag: ((WSTagsField, _ tag: WSTag) -> Void)?
  
  /**
   * Called when the view has updated its own height. If you are
   * not using Autolayout, you should use this method to update the
   * frames to make sure the tag view still fits.
   */
  open var onDidChangeHeightTo: ((_ height: CGFloat) -> Void)?
    
  
  //MARK:- IBOutlets
  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var alertLabel: UILabel!
  
  @IBOutlet weak var tagsView: UIView!
  
  @IBOutlet weak private var titleLabelLeadingConstraint: NSLayoutConstraint?
  @IBOutlet weak private var titleLabelTopConstraint: NSLayoutConstraint?
  @IBOutlet weak private var tagsFieldTopConstraint: NSLayoutConstraint?
  @IBOutlet weak private var tagsViewHeightConstraint: NSLayoutConstraint?
  
  //MARK:- Init
  public func setUp(with appearance: PSTagsFieldAppearance, placeHolder: String) {
    self.appearance = appearance
    self.placeholder = placeHolder
    
    setupTitle()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    self.viewWithTag(101)?.frame = self.bounds
    
    tagsField.frame = tagsView.bounds
    if isPlaceholderVisible { animateOut() }
  }
  
  private func commonInit() {
    _ = fromNib()
    setupView()
    setupTagsField()
    setupAlertTitle()
    setupVisualEffect()
  }
  
  private func setupView() {
    backgroundColor = .clear
    clipsToBounds = true
  }
  
  private func setupVisualEffect() {
    self.viewWithTag(101)?.removeFromSuperview()
    
    let visualEffectView = VisualEffectView(frame: self.bounds)
    visualEffectView.colorTint = appearance.visualEffectColorTint
    visualEffectView.colorTintAlpha = appearance.visualEffectColorTintAlpha
    visualEffectView.blurRadius = appearance.visualEffectBlurRadius
    visualEffectView.scale = appearance.visualEffectScale
    visualEffectView.tag = 101
    
    self.addSubview(visualEffectView)
    self.sendSubviewToBack(visualEffectView)
    self.layer.cornerRadius = 4.0
  }
  
  private func setupTagsField() {
    tagsField.frame = tagsView.bounds
    tagsView.addSubview(tagsField)
    tagsView.backgroundColor = .clear
    
    //tagsField.translatesAutoresizingMaskIntoConstraints = false
    //tagsField.heightAnchor.constraint(equalToConstant: 150).isActive = true

    tagsField.spaceBetweenLines = 15
    tagsField.spaceBetweenTags = 10

    tagsField.numberOfLines = 3
    //tagsField.maxHeight = 100.0

    tagsField.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    tagsField.contentInset = UIEdgeInsets(top: 4, left: 15, bottom: 15, right: 15) //old padding

    tagsField.placeholder = ""
    tagsField.placeholderColor = UIColor(white: 1.0, alpha: 0.8)
    tagsField.textField.textColor = .white
    tagsField.font = appearance.textFont
    tagsField.placeholderAlwaysVisible = true
    tagsField.backgroundColor = .clear
    tagsField.textField.returnKeyType = .search
    tagsField.delimiter = ""
    
    tagsField.tintColor = UIColor(red: 165.0 / 255.0, green: 204.0 / 255.0, blue: 1, alpha: 1)
    tagsField.textColor = UIColor(white: 0.0, alpha: 0.8)
    
    tagsField.selectedColor = UIColor(red: 85.0 / 255.0, green: 158.0 / 255.0, blue: 1, alpha: 1)
    tagsField.selectedTextColor = .white

    textFieldEvents()
  }
  
  private func setupTitle() {
    titleLabel.text = appearance.uppercasedTitles ? placeholder.uppercased() : placeholder
  }
  
  private func setupAlertTitle() {
    alertLabel.alpha = 0.0
  }
}

// CLASS METHODS

extension PSTagsField {
  
  func textFieldEvents() {
    
    tagsField.onBeginEditing = { [weak self] in
      self?.animateIn()
    }
    
    tagsField.onEndEditing = { [weak self] in
      if self?.tagsField.tags.isEmpty ?? false {
        self?.animateOut()
      }
    }
    
    tagsField.onDidAddTag = { [weak self] field, tag in
      self?.tagsField.placeholder = "Enter text"
      self?.onDidAddTag?(field, tag)
    }
    
    tagsField.onDidRemoveTag = { [weak self] field, tag in
      if self?.tagsField.tags.isEmpty ?? false { self?.tagsField.placeholder = "" }
      self?.onDidRemoveTag?(field, tag)
    }
    
  }
  
  func animateIn() {
    isPlaceholderVisible = false
    
    titleLabelTopConstraint?.constant = 6
    //tagsFieldTopConstraint?.constant = 25
    
    titleLabelLeadingConstraint?.constant = targetTitleLeadingPadding
    
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.titleLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
      self?.layoutIfNeeded()
    }
    
    titleLabel.textColor = appearance.titleColor
  }
  
  func animateOut() {
    isPlaceholderVisible = true
    
    titleLabelTopConstraint?.constant = self.frame.height/2.0 - titleLabel.frame.height/2.0
    
    //tagsFieldTopConstraint?.constant = 25
    titleLabelLeadingConstraint?.constant = 15
    
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.titleLabel.transform = .identity
      self?.layoutIfNeeded()
    }
    
    
    titleLabel.textColor = appearance.placeHolderColor
    
  }
  
  func animateInAlert(_ message: String?) {
    guard let message = message else { return }
    alertLabel.text = message
    UIView.animate(withDuration: 0.3, animations: { [weak self] in
      self?.titleLabel.alpha = 0.0
      self?.alertLabel.alpha = 1.0
    }) { [weak self] (completed) in
      self?.alertLabel.shake()
    }
  }
  
  func animateOutAlert() {
    alertLabel.text = ""
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.titleLabel.alpha = 1.0
      self?.alertLabel.alpha = 0.0
    }
  }
}

extension PSTagsField {
  
  open func showAlert(_ message: String? = nil) {
    guard appearance.alertEnabled else { return }
    animateInAlert(message)
  }
  
  open func hideAlert() {
    animateOutAlert()
  }
}
