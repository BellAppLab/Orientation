import AVFoundation


public extension UIDeviceOrientation
{
    public func toVideo() -> AVCaptureVideoOrientation
    {
        switch self
        {
        case .Portrait: return .Portrait
        case .PortraitUpsideDown: return .PortraitUpsideDown
        case .LandscapeLeft: return .LandscapeLeft
        case .LandscapeRight: return .LandscapeRight
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
        case .LandscapeLeft: return .LandscapeLeft
        case .LandscapeRight: return .LandscapeRight
        }
    }
}
