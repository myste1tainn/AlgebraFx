//
// Created by Arnon Keereena on 2019-05-08.
//

#if !(TARGET_OS_SIMUATOR || TARGET_OS_iOS)
// If the target is OS simulator or iOS then it is built with cocoapods
// and is using subspecs where module dependencies is not required.
import AlgebraFx
#endif
import Foundation
import RxSwift

func single<T>(_ obs: Observable<T>) -> Single<T> {
  return obs.asSingle()
}

func observable<T>(_ single: Single<T>) -> Observable<T> {
  return single.asObservable()
}

func --><T>(left: Single<T>, right: (Single<T>) -> Observable<T>) -> Observable<T> {
  return right(left)
}

func --><T>(left: Observable<T>, right: (Observable<T>) -> Single<T>) -> Single<T> {
  return right(left)
}
