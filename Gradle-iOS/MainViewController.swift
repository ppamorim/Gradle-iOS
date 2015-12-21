//
//  ViewController.swift
//  Gradle-iOS
//
//  Created by Pedro Paulo Amorim on 20/12/15.
//  Copyright © 2015 ppamorim. All rights reserved.
//

import UIKit
import PureLayout

class MainViewController: UIViewController {
  
  var didUpdateViewConstraints = false
  
  let blurLoadingView : UIView = {
    let blurLoadingView = UIView.newAutoLayoutView()
    if !UIAccessibilityIsReduceTransparencyEnabled() {
      blurLoadingView.backgroundColor = UIColor.clearColor()
      let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView.frame = blurLoadingView.bounds
      blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
      blurLoadingView.addSubview(blurEffectView)
    }
    return blurLoadingView
  }()
  
  let roundedStreamTextField : UIView = {
    let roundedStreamTextField = UIView.newAutoLayoutView()
    return roundedStreamTextField
  }()
  
  let streamNameTextField : UITextField = {
    let streamNameTextField = UITextField.newAutoLayoutView()
    streamNameTextField.attributedPlaceholder = NSAttributedString(string: "name_stream",
      attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
    streamNameTextField.textColor = UIColor.whiteColor()
    streamNameTextField.alpha = 0.8
    return streamNameTextField
  }()
  
  let tableView : UITableView = {
    let tableView = UITableView.newAutoLayoutView()
    tableView.backgroundColor = UIColor.clearColor()
    tableView.keyboardDismissMode = .OnDrag
    tableView.separatorInset.right = tableView.separatorInset.left
    return tableView
  }()

  override func loadView() {
    super.loadView()
    self.view.backgroundColor = UIColor(rgba: "#02303A")
    self.view.addSubview(tableView)
    self.view.addSubview(blurLoadingView)
    blurLoadingView.addSubview(roundedStreamTextField)
    roundedStreamTextField.addSubview(streamNameTextField)
    self.view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    if !didUpdateViewConstraints {
      tableView.autoPinEdgesToSuperviewEdges()
      
      blurLoadingView.autoPinEdgeToSuperviewEdge(.Top)
      blurLoadingView.autoPinEdgeToSuperviewEdge(.Left)
      blurLoadingView.autoPinEdgeToSuperviewEdge(.Right)
      
      roundedStreamTextField.autoPinEdge(.Left, toEdge: .Left, ofView: blurLoadingView, withOffset: 8.0)
      roundedStreamTextField.autoPinEdge(.Right, toEdge: .Right, ofView: blurLoadingView, withOffset: -8.0)
      roundedStreamTextField.autoPinEdge(.Top, toEdge: .Top, ofView: blurLoadingView, withOffset: 24.0)
      roundedStreamTextField.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: blurLoadingView, withOffset: -8.0)
      
      streamNameTextField.autoPinEdge(.Left, toEdge: .Left, ofView: roundedStreamTextField, withOffset: 8.0)
      streamNameTextField.autoPinEdge(.Right, toEdge: .Right, ofView: roundedStreamTextField, withOffset: -8.0)
      streamNameTextField.autoPinEdge(.Top, toEdge: .Top, ofView: roundedStreamTextField, withOffset: 8.0)
      streamNameTextField.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: roundedStreamTextField, withOffset: -8.0)
      
      let blurViewHeight = blurLoadingView.bounds.height
      tableView.contentInset = UIEdgeInsetsMake(blurViewHeight, 0, 0, 0)
      
      didUpdateViewConstraints = true
    }
    super.updateViewConstraints()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }


}

