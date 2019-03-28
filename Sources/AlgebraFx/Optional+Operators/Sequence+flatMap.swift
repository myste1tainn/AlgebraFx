//
// Created by Arnon Keereena on 2019-03-26.
//

import Foundation

extension Optional {
  public static func >-><Result>(left: Wrapped?, right: (Wrapped) throws -> Result?) rethrows -> Result? {
    return try left.flatMap { try right($0) }
  }
  
  public static func >-><Result>(left: Wrapped?, right: @autoclosure () throws -> Result?) rethrows -> Result? {
    return try left.flatMap { _ in try right() }
  }
  
  public static func >-><Result>(left: Wrapped?, right: KeyPath<Wrapped, Result?>) -> Result? {
    return left.flatMap { $0[keyPath: right] }
  }
}
