import UIKit

class DefaultButton: UIButton {

    private var tempLoadingColor: UIColor?
    private var tempLoadingTitleColor: UIColor?
    private var isLoading = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autoLocalize = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.autoLocalize = false
    }
    
    func setLoading(_ loading: Bool = true) {
        if loading {
            tempLoadingColor = self.backgroundColor
            tempLoadingTitleColor = self.titleLabel?.textColor
            isEnabled = false
            backgroundColor = .gray
            setTitleColor(.white, for: .normal)
            addActivityIndicator()
            isLoading = true
        } else {
            if isLoading {
                isEnabled = true
                backgroundColor = tempLoadingColor
                setTitleColor(tempLoadingTitleColor, for: .normal)
                self.subviews.forEach({
                    if $0 is UIActivityIndicatorView {
                        $0.removeFromSuperview()
                    }
                })
                isLoading = false
            }
        }
    }
    
    private func addActivityIndicator() {
        guard let titleLabel = self.titleLabel else { return }
        let indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = .init(style: .medium)
        } else {
            indicator = .init(style: .white)
        }
        indicator.color = .white
        addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalTo(titleLabel.snp.trailing).offset(15)
        }
        indicator.startAnimating()
    }
}
