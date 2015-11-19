import UIKit


public class Orientation
{
    //MARK: Singleton
    private weak static var singleton: Orientation?
    public static func shared() -> Orientation {
        if let result = self.singleton {
            return result
        }
        self.singleton = Orientation()
        return self.singleton!
    }
    
    //MARK: Setup
    deinit {
        UIDevice.currentDevice().endGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private init() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didRotate:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        self.check()
    }
    
    @objc private final func didRotate(notification: NSNotification)
    {
        self.check()
    }
    
    //MARK: Orientation
    private(set) final var current: UIDeviceOrientation = .Unknown
    public func check() -> UIDeviceOrientation
    {
        let orientation = UIDevice.currentDevice().orientation
        if !orientation.isValidInterfaceOrientation {
            return .Portrait //defaults to portrait
        }
        if orientation.isFlat {
            if !self.current.isValidInterfaceOrientation {
                //defaults to portrait
                self.current = .Portrait
            }
            return self.current
        }
        self.current = orientation
        return self.current
    }
}


public extension UIDeviceOrientation
{
    public func toInterface() -> UIInterfaceOrientation
    {
        switch self
        {
        case .Portrait: return .Portrait
        case .PortraitUpsideDown: return .PortraitUpsideDown
        case .LandscapeLeft: return .LandscapeLeft
        case .LandscapeRight: return .LandscapeRight
        default: return .Unknown
        }
    }
    
    public func toInterfaceMask() -> UIInterfaceOrientationMask
    {
        switch self
        {
        case .Portrait: return .Portrait
        case .PortraitUpsideDown: return .PortraitUpsideDown
        case .LandscapeLeft: return .LandscapeLeft
        case .LandscapeRight: return .LandscapeRight
        default: return .All
        }
    }
    
    public func toPrint() -> UIPrintInfoOrientation
    {
        switch self
        {
        case .Portrait, .PortraitUpsideDown: return .Portrait
        case .LandscapeLeft, .LandscapeRight: return .Landscape
        default: return .Portrait //Defaults to portrait
        }
    }
    
    public func toImage() -> UIImageOrientation
    {
        switch self
        {
        case .Portrait: return .Up
        case .PortraitUpsideDown: return .Down
        case .LandscapeLeft: return .Right
        case .LandscapeRight: return .Left
        default: return .Up //Defaults to up
        }
    }
}


public extension UIInterfaceOrientation
{
    public func toDevice() -> UIDeviceOrientation
    {
        switch self
        {
        case .Portrait: return .Portrait
        case .PortraitUpsideDown: return .PortraitUpsideDown
        case .LandscapeLeft: return .LandscapeLeft
        case .LandscapeRight: return .LandscapeRight
        default: return .Unknown
        }
    }
}


public extension UIInterfaceOrientationMask
{
    public func toDevice() -> UIDeviceOrientation
    {
        switch self
        {
        case UIInterfaceOrientationMask.Portrait: return .Portrait
        case UIInterfaceOrientationMask.PortraitUpsideDown: return .PortraitUpsideDown
        case UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.Landscape: return .LandscapeLeft
        case UIInterfaceOrientationMask.LandscapeRight: return .LandscapeRight
        default: return .Portrait //Defaults to portrait
        }
    }
}


public extension UIPrintInfoOrientation
{
    public func toDevice() -> UIDeviceOrientation
    {
        switch self
        {
        case .Portrait: return .Portrait
        case .Landscape: return .LandscapeLeft
        }
    }
}


public extension UIImageOrientation
{
    public func toDevice() -> UIDeviceOrientation
    {
        switch self
        {
        case .Down, .DownMirrored: return .PortraitUpsideDown
        case .Left, .LeftMirrored: return .LandscapeRight
        case .Right, .RightMirrored: return .LandscapeLeft
        case .Up, .UpMirrored: return .Portrait
        }
    }
    
    public var mirrored: Bool
    {
        switch self
        {
        case .LeftMirrored, .DownMirrored, .RightMirrored, .UpMirrored: return true
        default: return false
        }
    }
    
    public func mirror() -> UIImageOrientation {
        switch self
        {
        case .Down: return .DownMirrored
        case .Left: return .LeftMirrored
        case .Right: return .RightMirrored
        case .Up: return .UpMirrored
        case .DownMirrored: return .Down
        case .LeftMirrored: return .Left
        case .RightMirrored: return .Right
        case .UpMirrored: return .Up
        }
    }
}
