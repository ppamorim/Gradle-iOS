import Alamofire
import AlamofireObjectMapper
import ObjectMapper

private let _SearchServiceInstance = SearchService()

class SearchService {
  
  class var instance : SearchService {
    return _SearchServiceInstance
  }
  
  func search(completionHandler: (ErrorType?, [Project]?) -> (), filter : String) -> () {
    
    let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string:
      "http://search.maven.org/solrsearch/select?q=\(filter)&wt=json")!)
    mutableURLRequest.timeoutInterval = 30.0
    
    Alamofire.request(.GET, mutableURLRequest)
      .validate()
      .responseJSON { response in
        if let JSON = response.result.value {
          let result = (JSON as! NSDictionary).valueForKey("response")?.valueForKey("docs")
          let docs : [Project] = Mapper<Project>().mapArray(result!)!
          completionHandler(nil, docs)
        } else {
          completionHandler(response.result.error, nil)
        }
      }
  }
  
}