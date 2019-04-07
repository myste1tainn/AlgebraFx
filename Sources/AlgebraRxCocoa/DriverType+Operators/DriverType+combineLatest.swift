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
import RxCocoa

extension DriverType {
  public static func +++<R: DriverType>(left: Self, right: R) -> Driver<(E, R.E)> {
    return Driver.combineLatest(left, right)
  }
  
  public static func +++<A, B, R: DriverType>(left: Self, right: R) -> Driver<(A, B, R.E)> where E == (A, B) {
    return Driver.combineLatest(left, right) { ($0.0, $0.1, $1) }
  }
  
  public static func +++<A, B, C, R: DriverType>(left: Self, right: R) -> Driver<(A, B, C, R.E)> where E == (A, B, C) {
    return Driver.combineLatest(left, right) { ($0.0, $0.1, $0.2, $1) }
  }
  
  public static func +++<A, B, C, D, R: DriverType>(left: Self, right: R) -> Driver<(A, B, C, D, R.E)> where E == (A, B, C, D) {
    return Driver.combineLatest(left, right) { ($0.0, $0.1, $0.2, $0.3, $1) }
  }
  
  public static func ===<R: DriverType>(left: Self, right: R) -> Driver<Bool> where R.E == E, R.E: Equatable {
    return left +++ right >>> { $0.0 == $0.1 }
  }
  
  public static func &&&<R: DriverType>(left: Self, right: R) -> Driver<Bool> where R.E == E, R.E == Bool {
    return left +++ right >>> { $0.0 && $0.1 }
  }
}

public postfix func +++<T>(this: [Driver<T>]) -> Driver<[T]> {
  return Driver.combineLatest(this).asDriver()
}

