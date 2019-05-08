//
// Created by Arnon Keereena on 2019-03-26.
//

#if !(TARGET_OS_SIMUATOR || TARGET_OS_iOS)
// If the target is OS simulator or iOS then it is built with cocoapods
// and is using subspecs where module dependencies is not required.
import AlgebraFx
#endif
import Foundation
import RxCocoaExpansion
import RxSwift
import RxCocoa

extension ObservableType {
  public static func |>(left: Self, right: ActivityIndicator) -> Observable<E> {
    return left.trackActivity(right)
  }
  
  public static func |>(left: Self, right: ErrorTracker) -> Observable<E> {
    return left.trackError(right)
  }
  
  public static func |>(left: Self, right: (ActivityIndicator, ErrorTracker)) -> Observable<E> {
    return left.trackActivity(right.0)
               .trackError(right.1)
  }
  
}
