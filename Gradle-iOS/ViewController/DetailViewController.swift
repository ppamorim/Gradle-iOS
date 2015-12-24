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
  
  let detailProjectLabel : UILabel = {
    let detailProjectLabel = UILabel.newAutoLayoutView()
    detailProjectLabel.alpha = 0.0
    detailProjectLabel.lineBreakMode = .ByWordWrapping
    detailProjectLabel.numberOfLines = 0
    detailProjectLabel.textColor = UIColor(rgba: "#02303A")
    return detailProjectLabel
  }()
  
  override func loadView() {
    super.loadView()
    self.view.backgroundColor = UIColor.whiteColor()
    self.view.addSubview(topHeaderImage)
    self.view.addSubview(detailProjectLabel)
    self.view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    if !didUpdateViewConstraints {
      
      topHeaderImage.autoPinEdgeToSuperviewEdge(.Top)
      topHeaderImage.autoPinEdgeToSuperviewEdge(.Left)
      topHeaderImage.autoPinEdgeToSuperviewEdge(.Right)
      topHeaderImage.autoMatchDimension(.Height, toDimension: .Width, ofView: topHeaderImage, withMultiplier: 0.47)
      
      detailProjectLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: topHeaderImage, withOffset: 8.0)
      detailProjectLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 8.0)
      detailProjectLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 8.0)
      
      didUpdateViewConstraints = true
    }
    super.updateViewConstraints()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    loadProject()
  }
  
  func loadProject() {
    if project != nil {
      detailProjectLabel.text = "\("group_id".localized): \(project!.repositoryId)\n \("version".localized): \(project!.versionCount)"
      animateViews()
    }
  }
  
  func animateViews() {
    UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions(), animations: {
        self.detailProjectLabel.alpha = 1.0
      }, completion: { (finished: Bool) -> Void in
    })
  }
  
}