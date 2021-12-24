
class UserNameValidator: ValidatorConvertible {
    
    func validated(_ value: String?) throws -> String {
        guard let value = value else {
            throw ValidationError("Not exist")
        }
        if value.count < 2 {
            throw ValidationError("Min 2 characters")
        }
        if value.count > 30 {
            throw ValidationError("Max 30 characters")
        }
        return value
    }

}
