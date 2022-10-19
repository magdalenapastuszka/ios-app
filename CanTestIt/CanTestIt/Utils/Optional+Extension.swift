import Foundation

extension Optional {
    public var isNil: Bool {
        self == nil
    }
    
    public var isNotNil: Bool {
        !self.isNil
    }
}

extension Optional where Wrapped: Collection {
    public var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}
