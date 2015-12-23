import UIKit
import PureLayout

class ProjectViewCell : UITableViewCell {
  
  var didUpdateConstraints = false
  
  let title : UILabel = {
    let title = UILabel.newAutoLayoutView()
    title.textColor = UIColor.whiteColor()
    return title
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = UIColor.clearColor()
    contentView.backgroundColor = UIColor.clearColor()
    contentView.addSubview(title)
    self.updateConstraintsIfNeeded()
  }
  
  override func updateConstraints() {
    if !didUpdateConstraints {
      title.autoPinEdgeToSuperviewEdge(.Left, withInset: 16.0)
      title.autoPinEdgeToSuperviewEdge(.Right, withInset: 16.0)
      title.autoPinEdgeToSuperviewEdge(.Top)
      title.autoPinEdgeToSuperviewEdge(.Bottom)
      didUpdateConstraints = true
    }
    super.updateConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  func bind(project : Project) {
    title.text = project.id
  }
  
}