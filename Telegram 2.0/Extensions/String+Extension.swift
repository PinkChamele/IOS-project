import Foundation

extension String {
    
    func validated(of type: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: type)
        return try validator.validated(self)
    }
    
    func matching(expression regex: @autoclosure () throws -> NSRegularExpression) rethrows -> [String] {
        let results = try regex().matches(in: self, range: NSRange(self.startIndex..., in: self))
        return results.map {
            String(self[Range($0.range, in: self)!])
        }
    }

    func matching(pattern regexPattern: String) throws -> [String] {
        return try self.matching(expression: NSRegularExpression(pattern: regexPattern))
    }
    
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
