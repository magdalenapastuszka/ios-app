import Foundation

struct GetImagesRequest: HTTPRequest {
    typealias ReturnType = [String]
    
    let path: String = "images"
    var queryParams: HTTPQueryParams? = nil
    var method: HTTPMethod = .get
}
