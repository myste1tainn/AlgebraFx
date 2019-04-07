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
  public static func >-><R: DriverType>(left: Self, right: R) -> Driver<R.E> {
    return left.flatMap { _ in right }
  }
  
  public static func >-><R: DriverType>(left: Self, right: @escaping (E) -> R) -> Driver<R.E> {
    return left.flatMap { l in right(l) }
  }
  
  public static func >-><R: DriverType>(left: Self, right: @escaping (E) -> R) -> Driver<R.E> where E: OptionalType {
    return left.flatMap { l in right(l) }
  }
}

