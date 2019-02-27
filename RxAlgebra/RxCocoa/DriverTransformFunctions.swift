//
// Created by Arnon Keereena on 2019-02-15.
// Copyright (c) 2019 AMOS Thailand. All rights reserved.
//

import Foundation
import RxSwiftExpansion
import RxSwift
import RxCocoa

func driver<T: ObservableType>(_ obs: T, driveWith driver: Driver<T.E>) -> Driver<T.E> {
  return obs.asDriver(onErrorDriveWith: driver)
}

func driver<T: ObservableType>(_ obs: T) -> (T.E) -> Driver<T.E> {
  return {
    obs.asDriver(onErrorJustReturn: $0)
  }
}

func driver<T: ObservableType>(_ obs: T) -> Driver<T.E> {
  return obs.asDriverEmptyIfError()
}

func driver<T: ObservableType>(_ obs: T?) -> Driver<T.E>? {
  return obs?.asDriverEmptyIfError()
}

