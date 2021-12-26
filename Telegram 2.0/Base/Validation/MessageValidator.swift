class MessageValidator: ValidatorConvertible {
    
    func validated(_ value: String?) throws -> String {
        guard let value = value else {
            throw ValidationError("Not exist")
        }
        if value.count == 0 {
            throw ValidationError("Empty")
        }
        if value.replaceAll(regex: "\u{00A0}|\u{FEFF}|\u{202F}| ").isEmpty {
            throw ValidationError("Empty")
        }
        return value
    }

}
