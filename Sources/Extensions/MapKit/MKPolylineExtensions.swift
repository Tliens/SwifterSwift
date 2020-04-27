//
//  MKPolylineExtensions.swift
//  SwifterSwift
//
//  Created by Shai Mishali on 3/8/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(MapKit)
import MapKit

// MARK: - Initializers
#if !os(watchOS)
@available(tvOS 9.2, *)
public extension MKPolyline {

    /// 从提供的坐标数组创建一个新的MKPolyline。
    ///
    /// - Parameter coordinates: Array of CLLocationCoordinate2D(s).
    public convenience init(coordinates: [CLLocationCoordinate2D]) {
        var refCoordinates = coordinates
        self.init(coordinates: &refCoordinates, count: refCoordinates.count)
    }

}
#endif

#if !os(watchOS)
// MARK: - Properties
@available(tvOS 9.2, *)
public extension MKPolyline {

    /// 返回代表提供的折线的坐标数组。
    public var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }

}
#endif

#endif
