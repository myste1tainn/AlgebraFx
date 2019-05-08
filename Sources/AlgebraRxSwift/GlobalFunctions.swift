//
// Created by Arnon Keereena on 2019-04-06.
//

import Foundation
import RxSwift

public func toArray<T>(obs: Observable<T>) -> Observable<[T]> {
  return obs.toArray()
}
