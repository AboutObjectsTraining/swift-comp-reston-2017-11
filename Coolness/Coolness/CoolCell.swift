import UIKit

private let textInset = CGPoint(x: 12, y: 6)
private let textAttributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18),
                              NSAttributedStringKey.foregroundColor: UIColor.white]

class CoolCell: UIView
{
    var text: String?
    
    var highlighted: Bool = false {
        willSet {
            alpha = newValue ? 0.5 : 1.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        
        // TODO: Configure in IB
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(bounce))
        tapRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(tapRecognizer)
    }
    
    // FIXME: Implement me!
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Animation
extension CoolCell
{
    @objc func bounce() {
        animateBounce(duration: 1, size: CGSize(width: 120, height: 240))
    }
    
    func configureBounce(duration: TimeInterval, size: CGSize) {
        UIView.setAnimationRepeatCount(3.5)
        UIView.setAnimationRepeatAutoreverses(true)
        let translation = CGAffineTransform(translationX: size.width, y: size.height)
        transform = translation.rotated(by: CGFloat(.pi / 2.0))
    }
    
    func configureFinalBounce(duration: TimeInterval, size: CGSize) {
        print("In \(#function), \(#file):line \(#line)")
        UIView.animate(withDuration: duration) {
            [weak self] in self?.transform = CGAffineTransform.identity
        }
    }
    
    func animateBounce(duration: TimeInterval, size: CGSize) {
        UIView.animate(withDuration: duration,
                       animations: { [weak self]   in self?.configureBounce(duration: duration, size: size) },
                       completion: { [weak self] _ in self?.configureFinalBounce(duration: duration, size: size) })
    }
}

// MARK: - View Drawing
extension CoolCell
{
    override func draw(_ rect: CGRect) {
        guard let text = text else { return }
        (text as NSString).draw(at: textInset, withAttributes: textAttributes)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let text = text else { return size }
        var newSize = (text as NSString).size(withAttributes: textAttributes)
        newSize.width += 2 * textInset.x
        newSize.height += 2 * textInset.y
        return newSize
    }
}

// MARK: - Responder Methods
extension CoolCell
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = true
        guard let touch = touches.first, let view = touch.view else { return }
        view.superview?.bringSubview(toFront: view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currLocation = touch.location(in: nil)
        let prevLocation = touch.previousLocation(in: nil)
        center.x += currLocation.x - prevLocation.x
        center.y += currLocation.y - prevLocation.y
    }
    
    func finish(touch: UITouch?) {
        highlighted = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        finish(touch: touches.first)
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        finish(touch: touches.first)
    }
}
