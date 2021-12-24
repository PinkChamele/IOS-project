
class PasswordValidator: ValidatorConvertible {
        
    let confirmPassword: String?
    
    init(confirmPassword: String? = nil) {
        self.confirmPassword = confirmPassword
    }
    
    func validated(_ value: String?) throws -> String {
        guard let value = value else {
            throw ValidationError("Not exist")
        }
        if value.isEmpty {
            throw ValidationError("Empty pass")
        }
        if value.count < 8 {
            throw ValidationError("Min 8 characters")
        }
        if value.count > 30 {
            throw ValidationError("Max 30 characters")
        }
        if !value.matches("(?=.*[a-z])") {
            throw ValidationError("no lowercase")
        }
        if !value.matches("(?=.*[A-Z])") {
            throw ValidationError("no uperrcase")
        }
        if !value.matches("(?=.*\\d)") {
            throw ValidationError("no number")
        }
        if confirmPassword != nil {
            if confirmPassword!.isEmpty {
                throw ValidationError("no confirm password")
            }
            if value != confirmPassword {
                throw ValidationError("passwords are different")
            }
            
        }
        return value
    }

}
