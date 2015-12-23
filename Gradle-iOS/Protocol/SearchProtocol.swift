protocol SearchProtocol {
  func searchSuccess(projects : [Project])
  func searchNoResults()
  func searchFail()
}