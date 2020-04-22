//
//  UIStoryboardExtensions.swift
//  SwifterSwift
//
//  Created by Steven on 2/6/17.
//  Copyright © 2017 SwifterSwift
//

#if canImport(UIKit)  && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UIStoryboard {

    /// 获取应用程序的主故事板
    public static var main: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else { return nil }
        return UIStoryboard(name: name, bundle: bundle)
    }

    /// 使用类名实例化UIViewController
    ///
    /// - Parameter name: UIViewController type
    /// - Returns: The view controller corresponding to specified class name
    public func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: name)) as? T
    }

}
#endif
