//
// Created by Arnon Keereena on 2019-03-26.
//

import Foundation
import RxCocoaExpansion
import RxSwift
import RxCocoa

extension ObservableType {
  public static func |(left: Self, right: ActivityIndicator) -> Observable<E> {
    return left.trackActivity(right)
  }
  
  public static func |(left: Self, right: ErrorTracker) -> Observable<E> {
    return left.trackError(right)
  }
  
  public static func |(left: Self, right: (ActivityIndicator, ErrorTracker)) -> Observable<E> {
    return left.trackActivity(right.0)
               .trackError(right.1)
  }
  
}
