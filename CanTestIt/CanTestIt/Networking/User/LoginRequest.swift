import Foundation

struct LoginRequest: HTTPRequest {
    struct BodyModel: Encodable {
        let login: String
        let password: String
    }
    
    typealias ReturnType = String
    
    let path: String = "auth/login"
    var queryParams: HTTPQueryParams? = nil
    var method: HTTPMethod = .post
    var body: HTTPParams? {
        bodyModel.asDictionary
    }
    
    private let bodyModel: BodyModel
    
    init(bodyModel: BodyModel) {
        self.bodyModel = bodyModel
    }
}
