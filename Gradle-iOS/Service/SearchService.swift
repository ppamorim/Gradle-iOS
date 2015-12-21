import Alamofire
import AlamofireObjectMapper

private let _SearchServiceInstance = SearchService()

class SearchService {
  
  class var instance : SearchService {
    return _SearchServiceInstance
  }
  
  func search(completionHandler: (ErrorType?), filter : String) -> () {
    let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string:
      "https://gradleplease.appspot.com/search?q=\(filter)")!)
    
    print(mutableURLRequest)
    
    mutableURLRequest.timeoutInterval = 30.0
    Alamofire.request(.GET, mutableURLRequest)
      .validate()
      .response() { result in
        print(result)
      }
//      .responseArray {
//        (response: Response<[Camera], NSError>) in
//        let result = response.result.value!.map {
//          (camera) -> Camera in
//          camera.live = true
//          return camera
//        }
//        completionHandler(response.result.error, result)
  }
  
}