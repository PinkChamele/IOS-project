struct ConfirmResetPasswordRequest: Codable {
    let token: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case token
        case password = "new_password"
    }
}
