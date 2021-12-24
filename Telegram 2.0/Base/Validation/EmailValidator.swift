import Foundation

class EmailValidator: ValidatorConvertible {
    
    func validated(_ value: String?) throws -> String {
        do {
            let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
            if try NSRegularExpression(pattern: regex, options: .caseInsensitive).firstMatch(in: value!, options: [], range: NSRange(location: 0, length: value!.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return value!
    }

}
