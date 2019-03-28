//
// Created by Arnon Keereena on 2019-03-26.
//

import Foundation

extension Sequence {
  public static func >-><Result>(left: Self, right: (Element) throws -> Result?) rethrows -> [Result] {
    return try left.compactMap { try right($0) }
  }
  
  public static func >-><Result>(left: Self, right: @autoclosure () throws -> Result?) rethrows -> [Result] {
    return try left.compactMap { _ in try right() }
  }
  
  public static func >-><Result>(left: Self, right: KeyPath<Element, Result?>) -> [Result] {
    return left.compactMap { $0[keyPath: right] }
  }
}
