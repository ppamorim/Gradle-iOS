import Bolts

class SearchInteractor {
  
  var projects : [Project]? = nil
  var searchProtocol : SearchProtocol? = nil
  
  let searchService = SearchService.instance
  
  func search(filter : String) -> Void {
    self.requestSearch(filter).continueWithBlock {
      (task: BFTask!) -> BFTask? in
      
      if task.cancelled || task.error != nil {
        self.searchProtocol?.searchFail()
      } else {
        self.projects = task.result as? [Project]
        if self.projects != nil && self.projects?.count > 0 {
          self.searchProtocol?.searchSuccess(self.projects!)
        } else {
          self.searchProtocol?.searchNoResults()
        }
      }
      
      return nil
    }
  }
  
  func requestSearch(filter : String) -> BFTask {
    let task = BFTaskCompletionSource()
    searchService.search({ (error, projects) in
      if error == nil {
        task.setResult(projects)
      } else {
        task.setError(error!)
      }
    }, filter: filter)
    return task.task
  }
  
}