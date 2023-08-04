import Foundation

//validation class contains functions used by sign up view to validate form data such as passwords and names
class Validation {
    
    static func isPasswordValid(_ password: String) -> Bool {
        //Password must be at least 8 characters, contain uppercase, lowercase, numbers & special characters
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func isNameValid(_ name: String) -> Bool {
        //name must only contain letters and apostrophes and be less than 20 characters
        let nameTest = NSPredicate(format: "SELF MATCHES %@", "^(?!\\P{L})[\\p{L}'’\\s]{0,20}$")
        return nameTest.evaluate(with: name)
    }
}
