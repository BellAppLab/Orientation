import UIKit


public class Orientation
{
    //MARK: Singleton
    private weak static var singleton: Orientation?
    public static var shared: Orientation {
        if let result = self.singleton {
            return result
        }
        let result = Orientation()
        self.singleton = result
        return result
    }
    
    //MARK: Setup
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.removeObserver(self)
    }
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(Orientation.didRotate(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        self.check()
    }
    
    @objc private final func didRotate(_ notification: NSNotification)
    {
        self.check()
    }
    
    //MARK: Orientation
    private final var current: UIDeviceOrientation = .unknown
    
    @discardableResult
    public func check() -> UIDeviceOrientation
    {
        let orientation = UIDevice.current.orientation
        if self.current == .unknown
        {
            switch orientation
            {
            case .unknown, .faceUp, .faceDown: self.current = .portrait
            default: self.current = orientation
            }
        }
        else
        {
            switch orientation
            {
            case .unknown, .faceUp, .faceDown: break
            default: self.current = orientation
            }
        }
        return self.current
    }
}


public extension UIDeviceOrientation
{
    public var asInterface: UIInterfaceOrientation
    {
        switch self
        {
        case .portrait: return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeLeft
        case .landscapeRight: return .landscapeRight
        default: return .unknown
        }
    }
    
    public var toInterfaceMask: UIInterfaceOrientationMask
    {
        switch self
        {
        case .portrait: return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeLeft
        case .landscapeRight: return .landscapeRight
        default: return .all
        }
    }
    
    public var toPrint: UIPrintInfoOrientation
    {
        switch self
        {
        case .portrait, .portraitUpsideDown: return .portrait
        case .landscapeLeft, .landscapeRight: return .landscape
        default: return .portrait //Defaults to portrait
        }
    }
    
    public var toImage: UIImageOrientation
    {
        switch self
        {
        case .portrait: return .up
        case .portraitUpsideDown: return .down
        case .landscapeLeft: return .right
        case .landscapeRight: return .left
        default: return .up //Defaults to up
        }
    }
}


public extension UIInterfaceOrientation
{
    public var toDevice: UIDeviceOrientation
    {
        switch self
        {
        case .portrait: return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeLeft
        case .landscapeRight: return .landscapeRight
        default: return .unknown
        }
    }
}


public extension UIInterfaceOrientationMask
{
    public var toDevice: UIDeviceOrientation
    {
        switch self
        {
        case UIInterfaceOrientationMask.portrait: return .portrait
        case UIInterfaceOrientationMask.portraitUpsideDown: return .portraitUpsideDown
        case UIInterfaceOrientationMask.landscapeLeft, UIInterfaceOrientationMask.landscape: return .landscapeLeft
        case UIInterfaceOrientationMask.landscapeRight: return .landscapeRight
        default: return .portrait //Defaults to portrait
        }
    }
}


public extension UIPrintInfoOrientation
{
    public var toDevice: UIDeviceOrientation
    {
        switch self
        {
        case .portrait: return .portrait
        case .landscape: return .landscapeLeft
        }
    }
}


public extension UIImageOrientation
{
    public var toDevice: UIDeviceOrientation
    {
        switch self
        {
        case .down, .downMirrored: return .portraitUpsideDown
        case .left, .leftMirrored: return .landscapeRight
        case .right, .rightMirrored: return .landscapeLeft
        case .up, .upMirrored: return .portrait
        }
    }
    
    public var mirrored: Bool
    {
        switch self
        {
        case .leftMirrored, .downMirrored, .rightMirrored, .upMirrored: return true
        default: return false
        }
    }
    
    public var mirror: UIImageOrientation {
        switch self
        {
        case .down: return .downMirrored
        case .left: return .leftMirrored
        case .right: return .rightMirrored
        case .up: return .upMirrored
        case .downMirrored: return .down
        case .leftMirrored: return .left
        case .rightMirrored: return .right
        case .upMirrored: return .up
        }
    }
}
