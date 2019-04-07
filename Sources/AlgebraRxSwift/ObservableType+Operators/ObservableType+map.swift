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
  public static func >>>(left: Self, right: Void) -> Observable<Void> {
    return left.map { _ in }
  }
  
  public static func >>><R>(left: Self, right: R) -> Observable<R> {
    return left.map { _ in right }
  }
  
  public static func >>><R>(left: Self, right: @escaping (E) -> R) -> Observable<R> {
    return left.map { l -> R in right(l) }
  }
}
