import GrowingTextView

extension GrowingTextView {
    
    func `default`() {
        self.maxLength = 240
        self.trimWhiteSpaceWhenEndEditing = false
        self.placeholder = "Type your message..."
        self.placeholderColor = UIColor(white: 0.8, alpha: 1.0)
        self.minHeight = 25.0
        self.maxHeight = 80.0
        self.backgroundColor = .white
    }
}
