import UIKit
import PureLayout

class ProjectViewCell : UITableViewCell {
  
  var didUpdateConstraints = false
  
  let title : UILabel = {
    let title = UILabel.newAutoLayoutView()
    title.textColor = UIColor(rgba: "#3A3D3F")
    return title
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = UIColor.clearColor()
    contentView.addSubview(title)
    self.updateConstraintsIfNeeded()
  }
  
  override func updateConstraints() {
    if !didUpdateConstraints {
      title.autoPinEdgeToSuperviewEdge(.Right)
      title.autoPinEdgeToSuperviewEdge(.Top)
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