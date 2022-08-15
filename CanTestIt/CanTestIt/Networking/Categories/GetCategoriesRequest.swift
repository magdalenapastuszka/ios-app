import Foundation

struct GetCategoriesRequest: HTTPRequest {
    typealias ReturnType = [Category]
    
    let path: String = "categories"
    var queryParams: HTTPQueryParams? = nil
    var method: HTTPMethod = .get
}
