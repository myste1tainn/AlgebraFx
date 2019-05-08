//
// Created by Arnon Keereena on 2019-03-28.
//

import Foundation

extension Sequence {
  public static func +-+<Right: Sequence>(left: Self, right: Right) -> Zip2Sequence<Self, Right> {
    return zip(left, right)
  }
}
