//
// Created by Arnon Keereena on 2019-03-28.
//

#if !(TARGET_OS_SIMULATOR || TARGET_OS_IPHONE)
import AlgebraFx
#endif

import Foundation
import RxSwift

extension Single {
  public static func +-+<Right: Single>(left: Self, right: Right) -> Single<(Self.E, Right.E)> {
    return Single.zip(left, right)
  }
}

public postfix func +-+<T: Single>(target: [T]) -> Single<[T.E]> {
  return Single.zip(target)
}

public postfix func +-+<
                       A: Single,
                       B: Single
                       >(target: (A, B)) -> Single<(A.E,
                                                        B.E)> {
  return Single.zip(target.0, target.1)
}

public postfix func +-+<
                       A: Single,
                       B: Single,
                       C: Single
                       >(target: (A, B, C)) -> Single<(A.E,
                                                           B.E,
                                                           C.E)> {
  return Single.zip(target.0, target.1, target.2)
}

public postfix func +-+<
                       A: Single,
                       B: Single,
                       C: Single,
                       D: Single
                       >(target: (A, B, C, D)) -> Single<(A.E,
                                                              B.E,
                                                              C.E,
                                                              D.E)> {
  return Single.zip(target.0, target.1, target.2, target.3)
}
