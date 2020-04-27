//
//  SKNodeExtensions.swift
//  SwifterSwift
//
//  Created by Olivia Brown on 5/28/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(SpriteKit)
import SpriteKit

// MARK: - Methods
public extension SKNode {

    /// 返回所有SKNode后代的数组
    ///
    ///         mySKNode.descendants() -> [childNodeOne, childNodeTwo]
    ///
    public func descendants() -> [SKNode] {
        return children + children.reduce(into: [SKNode]()) { $0 += $1.descendants() }
    }

}
#endif
