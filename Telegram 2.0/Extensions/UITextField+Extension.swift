import UIKit
import SkyFloatingLabelTextField

extension UITextField {
    
    @discardableResult
    func validatedText(of type: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: type)
        return try validator.validated(self.text)
    }
}

extension SkyFloatingLabelTextField {
    
    func updateValidationResult(with type: ValidatorType) {
        do {
            try validatedText(of: type)
            errorMessage = nil
        } catch let error {
            let message = (error as! ValidationError).message
            errorMessage = message
        }
    }
    
    func `default`() {
        titleColor = .mainColor
        textColor = .black
    }
}
