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
  public static func -->(left: Self, right: Void) -> Disposable {
    return left.subscribe()
  }
  
  public static func -->(left: Self, right: @escaping (E) -> Void) -> Disposable {
    return left.subscribe(onNext: { right($0) })
  }
  
  public static func --><R>(left: Self, right: R) -> Disposable where E == R.E, R: ObserverType {
    return left.subscribe(right)
  }
}
