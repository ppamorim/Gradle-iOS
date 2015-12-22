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
  
  var projects : [Project]? = nil
  
  let searchService = SearchService.instance
  
  /**
   * No blur effect right now.
   */
  let blurLoadingView : UIView = {
    let blurLoadingView = UIView.newAutoLayoutView()
    blurLoadingView.backgroundColor = UIColor(rgba: "#84BA40")
//    if !UIAccessibilityIsReduceTransparencyEnabled() {
////      blurLoadingView.backgroundColor = UIColor.clearColor()
//      let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
//      let blurEffectView = UIVisualEffectView(effect: blurEffect)
//      blurEffectView.frame = blurLoadingView.bounds
//      blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
//      blurLoadingView.addSubview(blurEffectView)
//    }
    return blurLoadingView
  }()
  
  let roundedStreamTextField : UIView = {
    let roundedStreamTextField = UIView.newAutoLayoutView()
    roundedStreamTextField.backgroundColor = UIColor(rgba: "#116735")
    roundedStreamTextField.layer.cornerRadius = 5
    return roundedStreamTextField
  }()
  
  let streamNameTextField : UITextField = {
    let streamNameTextField = UITextField.newAutoLayoutView()
    streamNameTextField.attributedPlaceholder = NSAttributedString(string: "search".localized,
      attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
    streamNameTextField.textColor = UIColor.whiteColor()
    streamNameTextField.returnKeyType = UIReturnKeyType.Go
    return streamNameTextField
  }()
  
  let tableView : UITableView = {
    let tableView = UITableView.newAutoLayoutView()
    tableView.backgroundColor = UIColor.clearColor()
    tableView.registerClass(ProjectViewCell.self, forCellReuseIdentifier: "ProjectViewCell")
    tableView.keyboardDismissMode = .OnDrag
    tableView.separatorInset.right = tableView.separatorInset.left
    tableView.hidden = true
    return tableView
  }()
  
  let warningView : UILabel = {
    let warningView = UILabel.newAutoLayoutView()
    warningView.text = "no_library_found".localized
    warningView.textColor = UIColor.whiteColor()
    warningView.hidden = true
    return warningView
  }()
  
  let gradleView : UIImageView = {
    let gradleView = UIImageView.newAutoLayoutView()
    gradleView.image = UIImage(named : "gradle_icon")
    return gradleView
  }()

  override func loadView() {
    super.loadView()
    self.view.backgroundColor = UIColor(rgba: "#02303A")
    self.view.addSubview(warningView)
    self.view.addSubview(gradleView)
    self.view.addSubview(tableView)
    self.view.addSubview(blurLoadingView)
    blurLoadingView.addSubview(roundedStreamTextField)
    roundedStreamTextField.addSubview(streamNameTextField)
    self.view.setNeedsUpdateConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configDelegate()
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
      
      gradleView.autoMatchDimension(.Width, toDimension: .Width, ofView: self.view, withMultiplier: 0.4)
      gradleView.autoMatchDimension(.Height, toDimension: .Width, ofView: gradleView, withMultiplier: 0.4588)
      gradleView.autoCenterInSuperview()
      warningView.autoCenterInSuperview()
      
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
  
  func configDelegate() {
    streamNameTextField.delegate = self
    tableView.delegate = self
    tableView.dataSource = self
  }

  func showTableView() {
    gradleView.hidden = true
    tableView.hidden = false
    warningView.hidden = true
  }
  
  func showLoading() {
    gradleView.hidden = true
    tableView.hidden = true
    warningView.hidden = false
  }

}

extension MainViewController : UITextFieldDelegate {
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    let text = textField.text
    if text != nil && text?.characters.count > 0 {
      searchService.search({ (error, projects) in
        if error == nil && projects?.count > 0 {
          self.projects = projects
          self.tableView.reloadData()
          self.showTableView()
        }
        }, filter: text!)
    }
    return true
  }
  
}

extension MainViewController : UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    self.view.endEditing(true)
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 100
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
}

extension MainViewController : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.projects?.count ?? 0
  }
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    (cell as! ProjectViewCell).bind((self.projects![indexPath.row]))
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCellWithIdentifier("ProjectViewCell", forIndexPath: indexPath)
  }
  
}


