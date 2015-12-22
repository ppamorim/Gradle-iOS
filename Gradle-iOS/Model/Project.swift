import ObjectMapper

class Project : Mappable {
  
  dynamic var id: String = ""
  dynamic var latestVersion: String = ""
  dynamic var repositoryId: String = ""
  dynamic var versionCount: Int = 0
  
  required convenience init?(_ map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    latestVersion <- map["latestVersion"]
    repositoryId <- map["repositoryId"]
    versionCount <- map["versionCount"]
  }
  
}