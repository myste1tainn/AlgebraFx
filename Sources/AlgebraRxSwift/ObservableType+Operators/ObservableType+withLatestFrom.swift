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

extension ObservableType {
  public static func ||&<R: ObservableType>(left: Self, right: R) -> Observable<R.E> {
    return left.withLatestFrom(right)
  }
  
  public static func |&&<R: ObservableType>(left: Self, right: R) -> Observable<(E, R.E)> {
    return left.withLatestFrom(right) { ($0, $1) }
  }
  
  public static func |&&<A, B, R: ObservableType>(left: Self, right: R) -> Observable<(A, B, R.E)> where E == (A, B) {
    return left.withLatestFrom(right) { ($0.0, $0.1, $1) }
  }
  
  public static func |&&<A, B, C, R: ObservableType>(left: Self, right: R) -> Observable<(A, B, C, R.E)> where E == (A, B, C) {
    return left.withLatestFrom(right) { ($0.0, $0.1, $0.2, $1) }
  }
  
  public static func |&&<A, B, C, D, R: ObservableType>(left: Self, right: R) -> Observable<(A, B, C, D, R.E)> where E == (A, B, C, D) {
    return left.withLatestFrom(right) { ($0.0, $0.1, $0.2, $0.3, $1) }
  }
}
