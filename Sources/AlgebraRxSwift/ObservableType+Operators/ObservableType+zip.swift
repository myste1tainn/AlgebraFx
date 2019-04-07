//
// Created by Arnon Keereena on 2019-03-28.
//

#if !(TARGET_OS_SIMULATOR || TARGET_OS_IPHONE)
import AlgebraFx
#endif

import Foundation
import RxSwift

extension ObservableType {
  public static func +-+<Right: ObservableType>(left: Self, right: Right) -> Observable<(Self.E, Right.E)> {
    return Observable.zip(left, right)
  }
}

public postfix func +-+<T: ObservableType>(target: [T]) -> Observable<[T.E]> {
  return Observable.zip(target)
}

public postfix func +-+<
                       A: ObservableType,
                       B: ObservableType
                       >(target: (A, B)) -> Observable<(A.E,
                                                        B.E)> {
  return Observable.zip(target.0, target.1)
}

public postfix func +-+<
                       A: ObservableType,
                       B: ObservableType,
                       C: ObservableType
                       >(target: (A, B, C)) -> Observable<(A.E,
                                                           B.E,
                                                           C.E)> {
  return Observable.zip(target.0, target.1, target.2)
}

public postfix func +-+<
                       A: ObservableType,
                       B: ObservableType,
                       C: ObservableType,
                       D: ObservableType
                       >(target: (A, B, C, D)) -> Observable<(A.E,
                                                              B.E,
                                                              C.E,
                                                              D.E)> {
  return Observable.zip(target.0, target.1, target.2, target.3)
}
