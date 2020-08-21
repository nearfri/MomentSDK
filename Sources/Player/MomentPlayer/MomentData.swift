import Foundation
import MomentPlayerView
import MomentPlayerDomain
import Alamofire

public struct MomentData {
    public var text = "Hello, World!"
    
    public init() {}
    
    public func foo() {
        let aa = ViewData()
        print(aa)
        
        AF.request("https://httpbin.org/headers").responseJSON { response in
            print("player", response)
        }
    }
}
