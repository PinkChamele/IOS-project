protocol ValidatorConvertible {
    func validated(_ value: String?) throws -> String
}

enum ValidatorType {
    case email
    case password(confirmPassword: String? = nil)
    case username
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email:
            return EmailValidator()
        case .password(let confirmPassword):
            return PasswordValidator(confirmPassword: confirmPassword)
        case .username:
            return UserNameValidator()
        }
    }
}
