//
// Created by Arnon Keereena on 2019-04-06.
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

extension Single where E: OptionalType {
  public static postfix func ~~!(this: Self) -> Single<E.Wrapped> {
    return this.unwrap()
  }
}
