//
// Created by Arnon Keereena on 2019-03-28.
//

#if !(TARGET_OS_SIMULATOR || TARGET_OS_IPHONE)
import AlgebraFx
#endif

import Foundation
import RxSwift

extension DriverType {
  public static func +-+<Right: DriverType>(left: Self, right: Right) -> Driver<(Self.E, Right.E)> {
    return Driver.zip(left, right)
  }
}

public postfix func +-+<T: DriverType>(target: [T]) -> Driver<[T.E]> {
  return Driver.zip(target)
}

public postfix func +-+<
                       A: DriverType,
                       B: DriverType
                       >(target: (A, B)) -> Driver<(A.E,
                                                        B.E)> {
  return Driver.zip(target.0, target.1)
}

public postfix func +-+<
                       A: DriverType,
                       B: DriverType,
                       C: DriverType
                       >(target: (A, B, C)) -> Driver<(A.E,
                                                           B.E,
                                                           C.E)> {
  return Driver.zip(target.0, target.1, target.2)
}

public postfix func +-+<
                       A: DriverType,
                       B: DriverType,
                       C: DriverType,
                       D: DriverType
                       >(target: (A, B, C, D)) -> Driver<(A.E,
                                                              B.E,
                                                              C.E,
                                                              D.E)> {
  return Driver.zip(target.0, target.1, target.2, target.3)
}
