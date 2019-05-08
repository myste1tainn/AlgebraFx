//
// Created by Arnon Keereena on 2019-02-14.
// Copyright (c) 2019 AMOS Thailand. All rights reserved.
//

#if !(TARGET_OS_SIMUATOR || TARGET_OS_iOS)
// If the target is OS simulator or iOS then it is built with cocoapods
// and is using subspecs where module dependencies is not required.

import AlgebraFx
#endif
import Foundation
import SwiftExpansion
import RxSwiftExpansion
import RxSwift

extension Single {
  public static func ||&<R: Single>(left: Self, right: R) -> Single<R.E> {
    return left.withLatestFrom(right)
  }
  
  public static func |&&<R: Single>(left: Self, right: R) -> Single<(E, R.E)> {
    return left.withLatestFrom(right) { ($0, $1) }
  }
  
  public static func |&&<A, B, R: Single>(left: Self, right: R) -> Single<(A, B, R.E)> where E == (A, B) {
    return left.withLatestFrom(right) { ($0.0, $0.1, $1) }
  }
  
  public static func |&&<A, B, C, R: Single>(left: Self, right: R) -> Single<(A, B, C, R.E)> where E == (A, B, C) {
    return left.withLatestFrom(right) { ($0.0, $0.1, $0.2, $1) }
  }
  
  public static func |&&<A, B, C, D, R: Single>(left: Self, right: R) -> Single<(A, B, C, D, R.E)> where E == (A, B, C, D) {
    return left.withLatestFrom(right) { ($0.0, $0.1, $0.2, $0.3, $1) }
  }
}
