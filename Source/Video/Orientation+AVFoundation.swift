import AVFoundation


public extension UIDeviceOrientation
{
    public func toVideo() -> AVCaptureVideoOrientation
    {
        switch self
        {
        case .PortraitUpsideDown: return .PortraitUpsideDown
        case .LandscapeLeft: return .LandscapeRight
        case .LandscapeRight: return .LandscapeLeft
        default: return .Portrait //Defaults to Portrait
        }
    }
}


public extension AVCaptureVideoOrientation
{
    public func toDevice() -> UIDeviceOrientation
    {
        switch self
        {
        case .Portrait: return .Portrait
        case .PortraitUpsideDown: return .PortraitUpsideDown
        case .LandscapeLeft: return .LandscapeRight
        case .LandscapeRight: return .LandscapeLeft
        }
    }
}
