import UIKit
import PureLayout

class DetailViewController: UIViewController {
  
  var didUpdateViewConstraints = false
  
  var project : Project? = nil
  
  let topHeaderImage : UIImageView = {
    let topHeaderImage = UIImageView.newAutoLayoutView()
    topHeaderImage.backgroundColor = UIColor(rgba: "#84BA40")
    return topHeaderImage
  }()
  
  let returnButton : UIButton = {
    let returnButton = UIButton.newAutoLayoutView()
    returnButton.setTitle("return".localized, forState: .Normal)
    returnButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    return returnButton
  }()
  
  let containerGradle : UIView = {
    let containerGradle = UIView.newAutoLayoutView()
    containerGradle.backgroundColor = UIColor(rgba: "#116735")
    return containerGradle
  }()
  
  let gradleLabel : UILabel = {
    let gradleLabel = UILabel.newAutoLayoutView()
    gradleLabel.text = " "
    gradleLabel.textColor = UIColor.whiteColor()
    gradleLabel.textAlignment = .Center
    gradleLabel.lineBreakMode = .ByWordWrapping
    gradleLabel.numberOfLines = 0
    gradleLabel.alpha = 0.0
    return gradleLabel
  }()
  
  let gradleCommentLabel : UILabel = {
    let gradleCommentLabel = UILabel.newAutoLayoutView()
    gradleCommentLabel.text = "press_to_copy".localized
    gradleCommentLabel.textColor = UIColor(rgba: "#84BA40")
    gradleCommentLabel.textAlignment = .Center
    gradleCommentLabel.font = gradleCommentLabel.font.fontWithSize(10)
    gradleCommentLabel.alpha = 0.0
    return gradleCommentLabel
  }()
  
  let groupId : UILabel = {
    let groupId = UILabel.newAutoLayoutView()
    groupId.alpha = 0.0
    groupId.lineBreakMode = .ByWordWrapping
    groupId.numberOfLines = 0
    groupId.textColor = UIColor(rgba: "#02303A")
    groupId.font = groupId.font.fontWithSize(12)
    return groupId
  }()
  
  let artifactId : UILabel = {
    let artifactId = UILabel.newAutoLayoutView()
    artifactId.text = "artifact_id".localized
    artifactId.alpha = 0.0
    artifactId.lineBreakMode = .ByWordWrapping
    artifactId.numberOfLines = 0
    artifactId.textColor = UIColor(rgba: "#02303A")
    artifactId.font = artifactId.font.fontWithSize(12)
    return artifactId
  }()
  
  let versionCount : UILabel = {
    let versionCount = UILabel.newAutoLayoutView()
    versionCount.text = "artifact_id".localized
    versionCount.alpha = 0.0
    versionCount.lineBreakMode = .ByWordWrapping
    versionCount.numberOfLines = 0
    versionCount.textColor = UIColor(rgba: "#02303A")
    versionCount.font = versionCount.font.fontWithSize(12)
    return versionCount
  }()
  
//  let detailProjectLabel : UILabel = {
//    let detailProjectLabel = UILabel.newAutoLayoutView()
//    detailProjectLabel.alpha = 0.0
//    detailProjectLabel.lineBreakMode = .ByWordWrapping
//    detailProjectLabel.numberOfLines = 0
//    detailProjectLabel.textColor = UIColor(rgba: "#02303A")
//    detailProjectLabel.font = detailProjectLabel.font.fontWithSize(12)
//    return detailProjectLabel
//  }()
  
  override func loadView() {
    super.loadView()
    
    self.view.backgroundColor = UIColor.whiteColor()
    
    self.view.addSubview(topHeaderImage)
    self.view.addSubview(returnButton)
    self.view.addSubview(containerGradle)
    self.view.addSubview(groupId)
    self.view.addSubview(artifactId)
    self.view.addSubview(versionCount)
    
    containerGradle.addSubview(gradleLabel)
    containerGradle.addSubview(gradleCommentLabel)
    
    self.view.setNeedsUpdateConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configTarget()
  }
  
  override func updateViewConstraints() {
    if !didUpdateViewConstraints {
      
      topHeaderImage.autoPinEdgeToSuperviewEdge(.Top)
      topHeaderImage.autoPinEdgeToSuperviewEdge(.Left)
      topHeaderImage.autoPinEdgeToSuperviewEdge(.Right)
      topHeaderImage.autoMatchDimension(.Height, toDimension: .Width, ofView: topHeaderImage, withMultiplier: 0.47)
      
      let basePadding : CGFloat = 16.0
      
      returnButton.autoPinEdgeToSuperviewEdge(.Left, withInset: basePadding)
      returnButton.autoPinEdgeToSuperviewEdge(.Top, withInset: 24.0)
      
      containerGradle.autoPinEdge(.Top, toEdge: .Bottom, ofView: topHeaderImage)
      containerGradle.autoPinEdgeToSuperviewEdge(.Left)
      containerGradle.autoPinEdgeToSuperviewEdge(.Right)
      
      gradleLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerGradle, withOffset: 8.0)
      gradleLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerGradle, withOffset: -8.0)
      gradleLabel.autoPinEdge(.Top, toEdge: .Top, ofView: containerGradle, withOffset: 8.0)
      
      gradleCommentLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerGradle, withOffset: 8.0)
      gradleCommentLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerGradle, withOffset: -8.0)
      gradleCommentLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: gradleLabel, withOffset: 2.0)
      gradleCommentLabel.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: containerGradle, withOffset: -8.0)

      groupId.autoPinEdge(.Top, toEdge: .Bottom, ofView: containerGradle, withOffset: basePadding)
      groupId.autoPinEdgeToSuperviewEdge(.Left, withInset: basePadding)
      groupId.autoPinEdgeToSuperviewEdge(.Right, withInset: basePadding)
      
      artifactId.autoPinEdge(.Top, toEdge: .Bottom, ofView: groupId, withOffset: basePadding)
      artifactId.autoPinEdgeToSuperviewEdge(.Left, withInset: basePadding)
      artifactId.autoPinEdgeToSuperviewEdge(.Right, withInset: basePadding)
      
      versionCount.autoPinEdge(.Top, toEdge: .Bottom, ofView: artifactId, withOffset: basePadding)
      versionCount.autoPinEdgeToSuperviewEdge(.Left, withInset: basePadding)
      versionCount.autoPinEdgeToSuperviewEdge(.Right, withInset: basePadding)
      
      didUpdateViewConstraints = true
    }
    super.updateViewConstraints()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    loadProject()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  func configTarget() {
    returnButton.addTarget(self, action: "returnClick", forControlEvents: .TouchUpInside)
  }
  
  func returnClick() {
    self.project = nil
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func loadProject() {
    if project != nil {
      groupId.text = "\("group_id".localized): \(project!.groupId)"
      artifactId.text = "\("artifact_id".localized): \(project!.artifactId)"
      versionCount.text = "\("version".localized): \(project!.versionCount)"
      gradleLabel.text = project!.id
      animateViews()
    }
  }
  
  func animateViews() {
    UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: {
        self.groupId.alpha = 1.0
        self.artifactId.alpha = 1.0
        self.versionCount.alpha = 1.0
        self.gradleLabel.alpha = 1.0
        self.gradleCommentLabel.alpha = 1.0
      }, completion: { (finished: Bool) -> Void in
    })
  }
  
}