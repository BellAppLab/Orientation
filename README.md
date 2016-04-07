# Orientation

[![CI Status](http://img.shields.io/travis/Bell App Lab/Orientation.svg?style=flat)](https://travis-ci.org/Bell App Lab/Orientation)
[![Version](https://img.shields.io/cocoapods/v/Orientation.svg?style=flat)](http://cocoapods.org/pods/Orientation)
[![License](https://img.shields.io/cocoapods/l/Orientation.svg?style=flat)](http://cocoapods.org/pods/Orientation)
[![Platform](https://img.shields.io/cocoapods/p/Orientation.svg?style=flat)](http://cocoapods.org/pods/Orientation)

## Usage

According to the docs on `UIDevice.currentDevice().orientation`:

>The value of this property always returns 0 unless orientation notifications have been enabled by calling `beginGeneratingDeviceOrientationNotifications`.

Also, calling `endGeneratingDeviceOrientationNotifications` seems to be a good idea, to preserve batery life.

Thus, this library not only normalizes the various types of orientations iOS works with (`UIDeviceOrientation`, `UIInterfaceOrientation`, `UIImageOrientation` and optionally `AVCaptureVideoOrientation`), but also attempts to optimize the generation of such rotation notifications by creating a shared weak singleton that will only stay alive as long as there's an object needing it (ie. holding a strong reference to it) and that will end the generation of orientation notifications when it's deinit'ed.

**Here's how to use it**:

```swift
class ViewController: UIViewController {

    let orientation = Orientation.shared()

    override public func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {

        /*
            We need to call `check()`, because iOS only produces the `UIDeviceOrientationDidChangeNotification` and not its `UIDeviceOrientationWillChangeNotification` counterpart. So the current orientation will only by updated automatically when the rotation finishes.
            How is this better than checking for `UIDevice.currentDevice().orientation`? Because if the device moves from `UIDeviceOrientationPortrait` to `UIDeviceOrientationFaceUp`, we maintain it as `UIDeviceOrientationPortrait`. After all, your UI doesn't really need to change when the device is sitting on its back, does it?
            Also, you may simply disregard `UIInterfaceOrientation`. Neat, huh?
        */
        let currentOrientation = self.orientation.check()

        switch currentOrientation 
        {
            case .Portrait: //do something if we are portrait
            default: //else case
        }

        coordinator.notifyWhenInteractionEndsUsingBlock { [unowned self] (ctx: UIViewControllerTransitionCoordinatorContext) -> Void in
            if !ctx.isInteractive() {
                //no need to call check, because now it's been checked automatically
                let currentOrientation = self.orientation.current 
                /* ... */
            }
        }

        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
}
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

### CocoaPods

Orientation is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Orientation/Core"
```

To work with AVFoundation:

```ruby
pod "Orientation/Video"
```

To have everything (that is and will be):
```ruby
pod "Orientation/All"
```

**Note:** Do not add `Orientation` to your project as it is equivalent to `All` (unless you know what you're doing)

### Git Submodules

**Why submodules, you ask?**

Following [this thread](http://stackoverflow.com/questions/31080284/adding-several-pods-increases-ios-app-launch-time-by-10-seconds#31573908) and other similar to it, and given that Cocoapods only works with Swift by adding the use_frameworks! directive, there's a strong case for not bloating the app up with too many frameworks. Although git submodules are a bit trickier to work with, the burden of adding dependencies should weigh on the developer, not on the user. :wink:

To install Orientation using git submodules:

```
cd toYourProjectsFolder
git submodule add -b Submodule --name Orientation https://github.com/BellAppLab/Orientation.git
```

Navigate to the new Orientation folder and drag the Pods folder to your Xcode project.

## Author

Bell App Lab, apps@bellapplab.com

## License

Orientation is available under the MIT license. See the LICENSE file for more info.
