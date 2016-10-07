import UIKit
import AVFoundation


public extension UIDeviceOrientation
{
    public var asVideo: AVCaptureVideoOrientation
    {
        switch self
        {
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeRight
        case .landscapeRight: return .landscapeLeft
        default: return .portrait //Defaults to Portrait
        }
    }
}


public extension AVCaptureVideoOrientation
{
    public var asDevice: UIDeviceOrientation
    {
        switch self
        {
        case .portrait: return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeRight
        case .landscapeRight: return .landscapeLeft
        }
    }
}
