---
title: Responsive Dark Mode in UIKit
slug: responsive-darkmode-uikit
date: 2020-05-24 21:15
date_updated: 2020-05-25T11:24:02.000Z
tags: swift, swiftui, apple, iOS
---

I was looking for a way to bring out the AirPlay menu in SwiftUI when I found this [StackOverflow Answer](https://stackoverflow.com/a/60085342/3588557). Issue with that solution is the AirPlay button not changing colorscheme when the rest of the system does:
![](/content/images/2020/05/output-2.gif)
There's a quick and easy fix however! `UIKit` has a nifty `traitCollectionDidChange(_:)` function, which gets called when — amongst other — dark mode turns on. So to fix this interesting bug, you have to bring `button` out to the class, and change the colour in `traitCollectionDidChange(_:)` so it looks as follows:

```swift
class AirPLayViewController: UIViewController {
    let button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isDarkMode = self.traitCollection.userInterfaceStyle == .dark
        
        
        let boldConfig = UIImage.SymbolConfiguration(scale: .large)
        let boldSearch = UIImage(systemName: "airplayaudio",
                                 withConfiguration: boldConfig)

        button.setImage(boldSearch, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.tintColor = isDarkMode ? .white : .black

        button.addTarget(self,
                         action: #selector(self.showAirPlayMenu(_:)),
                         for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let isDarkMode = self.traitCollection.userInterfaceStyle == .dark
        button.tintColor = isDarkMode ? .white : .black
    }
    
    // copied from https://stackoverflow.com/a/44909445/7974174
    @objc func showAirPlayMenu(_ sender: UIButton){ 
        let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
        let airplayVolume = MPVolumeView(frame: rect)
        airplayVolume.showsVolumeSlider = false
        self.view.addSubview(airplayVolume)
        for view: UIView in airplayVolume.subviews {
            if let button = view as? UIButton {
                button.sendActions(for: .touchUpInside)
                break
            }
        }
        airplayVolume.removeFromSuperview()
    }
}
```

I hope my quick tip helped, if only for a bit!
