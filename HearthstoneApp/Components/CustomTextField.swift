import UIKit

final class CustomTextField: UITextField {
    private let padding: CGFloat = 45
    
    private let placeholderText: String
    
    init(placeholderText: String = "") {
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        configurate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurate() {
        placeholder = placeholderText
        tintColor = .darkGray
        textColor = .black
        layer.cornerRadius = 12
        layer.borderWidth = 1
        borderStyle = .roundedRect
        layer.borderColor = UIColor.darkGray.cgColor
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
    
    func setupLeftImageView(image: UIImage, with color: UIColor) {
        let leftImage = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        leftImage.frame = CGRect(x: 10, y: self.frame.height / 2 + 12, width: 25, height: 20)
        self.addSubview(leftImage)
        tintColor = color
    }
}
