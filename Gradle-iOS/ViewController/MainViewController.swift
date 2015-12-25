import UIKit
import PureLayout

class MainViewController: UIViewController {
  
  var didUpdateViewConstraints = false
  
  let searchService = SearchService.instance
  
  var searchInteractor : SearchInteractor? = nil
  
  let topView : UIView = {
    let topView = UIView.newAutoLayoutView()
    topView.backgroundColor = UIColor(rgba: "#84BA40")
    return topView
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
    streamNameTextField.autocorrectionType = .No
    streamNameTextField.autocapitalizationType = .None
    return streamNameTextField
  }()
  
  let tableView : UITableView = {
    let tableView = UITableView.newAutoLayoutView()
    tableView.backgroundColor = UIColor.clearColor()
    tableView.registerClass(ProjectViewCell.self, forCellReuseIdentifier: "ProjectViewCell")
    tableView.keyboardDismissMode = .OnDrag
    tableView.separatorInset.right = tableView.separatorInset.left
    tableView.tableFooterView = UIView()
    tableView.showsVerticalScrollIndicator = false
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
  
  let loadingView : UIActivityIndicatorView = {
    let loadingView = UIActivityIndicatorView.newAutoLayoutView()
    loadingView.hidden = true
    loadingView.color = UIColor(rgba: "#84BA40")
    return loadingView
  }()

  deinit {
    searchInteractor = nil
  }
  
  override func loadView() {
    super.loadView()
    self.view.backgroundColor = UIColor(rgba: "#02303A")
    self.view.addSubview(warningView)
    self.view.addSubview(loadingView)
    self.view.addSubview(gradleView)
    self.view.addSubview(tableView)
    self.view.addSubview(topView)
    topView.addSubview(roundedStreamTextField)
    roundedStreamTextField.addSubview(streamNameTextField)
    self.view.setNeedsUpdateConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configDelegate()
    configInteractors()
  }
  
  override func updateViewConstraints() {
    if !didUpdateViewConstraints {
      
      tableView.autoPinEdgesToSuperviewEdges()
      gradleView.autoCenterInSuperview()
      warningView.autoCenterInSuperview()
      loadingView.autoCenterInSuperview()
      
      topView.autoPinEdgeToSuperviewEdge(.Top)
      topView.autoPinEdgeToSuperviewEdge(.Left)
      topView.autoPinEdgeToSuperviewEdge(.Right)
      
      roundedStreamTextField.autoPinEdge(.Left, toEdge: .Left, ofView: topView, withOffset: 8.0)
      roundedStreamTextField.autoPinEdge(.Right, toEdge: .Right, ofView: topView, withOffset: -8.0)
      roundedStreamTextField.autoPinEdge(.Top, toEdge: .Top, ofView: topView, withOffset: 24.0)
      roundedStreamTextField.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: topView, withOffset: -8.0)
      
      streamNameTextField.autoPinEdge(.Left, toEdge: .Left, ofView: roundedStreamTextField, withOffset: 10.0)
      streamNameTextField.autoPinEdge(.Right, toEdge: .Right, ofView: roundedStreamTextField, withOffset: -10.0)
      streamNameTextField.autoPinEdge(.Top, toEdge: .Top, ofView: roundedStreamTextField, withOffset: 8.0)
      streamNameTextField.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: roundedStreamTextField, withOffset: -8.0)
      
      gradleView.autoMatchDimension(.Width, toDimension: .Width, ofView: self.view, withMultiplier: 0.4)
      gradleView.autoMatchDimension(.Height, toDimension: .Width, ofView: gradleView, withMultiplier: 0.4588)
      
      didUpdateViewConstraints = true
    }
    super.updateViewConstraints()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.contentInset = UIEdgeInsetsMake(topView.bounds.height, 0, 0, 0)
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func configInteractors() {
    self.searchInteractor = SearchInteractor()
    searchInteractor?.searchProtocol = self
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
    loadingView.hidden = true
    loadingView.stopAnimating()
  }
  
  func showLoading() {
    gradleView.hidden = true
    tableView.hidden = true
    warningView.hidden = true
    loadingView.hidden = false
    loadingView.startAnimating()
  }
  
  func showWarning() {
    gradleView.hidden = true
    tableView.hidden = true
    warningView.hidden = false
    loadingView.hidden = true
    loadingView.stopAnimating()
  }
  
  func loadProject(project : Project) {
    let detailViewController : DetailViewController = DetailViewController()
    detailViewController.project = project
    self.presentViewController(detailViewController, animated: true, completion: nil)
  }

}

extension MainViewController : UITextFieldDelegate {
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    let text = textField.text
    if text != nil && text?.characters.count > 0 {
      showLoading()
      searchInteractor?.search(text!)
    }
    return true
  }
  
}

extension MainViewController : SearchProtocol {
  
  func searchSuccess(projects : [Project]) {
    self.tableView.reloadData()
    self.showTableView()
  }
  
  func searchNoResults() {
    showWarning()
  }
  
  func searchFail() {
    showWarning()
  }
  
}

extension MainViewController : UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    loadProject((searchInteractor!.projects![indexPath.row]))
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    self.view.endEditing(true)
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 50
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 50
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
}

extension MainViewController : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchInteractor!.projects?.count ?? 0
  }
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    (cell as! ProjectViewCell).bind((searchInteractor!.projects![indexPath.row]))
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCellWithIdentifier("ProjectViewCell", forIndexPath: indexPath)
  }
  
}


