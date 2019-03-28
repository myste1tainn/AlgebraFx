//
// Created by Arnon Keereena on 2019-03-26.
//

import Foundation

extension Sequence {
  public static func >>><Result>(left: Self, right: (Element) -> Result) -> [Result] {
    return left.map { right($0) }
  }
  
  public static func >>><Result>(left: Self, right: @autoclosure () -> Result) -> [Result] {
    return left.map { _ in right() }
  }
  
  public static func >>><Result>(left: Self, right: KeyPath<Element, Result>) -> [Result] {
    return left.map { $0[keyPath: right] }
  }
}
