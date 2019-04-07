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
  public static func >--<R: ObservableType>(left: Self, right: R) -> Observable<R.E> {
    return left.flatMapLatest { _ in right.asObservable() }
  }
  
  public static func >--<R>(left: Self, right: @escaping (E) -> Observable<R>) -> Observable<R> {
    return left.flatMapLatest { right($0) }
  }
}
