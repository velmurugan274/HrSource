//import Foundation
//class Downloader {
//    class func load(URL: NSURL) {
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//        let request = NSMutableURLRequest(url: URL as URL)
//        request.httpMethod = "GET"
//        let task = session.downloadTask(with: <#T##URLRequest#>)
//        
//        
//        let task = session.dat dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: URLResponse!, error: NSError!) -> Void in
//            if (error == nil) {
//                // Success
//                let statusCode = (response as NSHTTPURLResponse).statusCode
//                println("Success: \(statusCode)")
//                
//                // This is your file-variable:
//                // data
//            }
//            else {
//                // Failure
//                println("Failure: %@", error.localizedDescription);
//            }
//        })
//        task.resume()
//    }
//}
