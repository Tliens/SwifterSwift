//
//  UISwitchExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 08/12/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit)  && os(iOS)
import UIKit

// MARK: - Methods
public extension UISwitch {

    /// 切换UISwitch
    ///
    /// - Parameter animated: set true to animate the change (default is true)
    public func toggle(animated: Bool = true) {
        setOn(!isOn, animated: animated)
    }

}
#endif
