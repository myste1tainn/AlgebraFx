//
// Created by Arnon Keereena on 2019-02-15.
// Copyright (c) 2019 AMOS Thailand. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public typealias DriverFullBreakdownResult<T: DriverType> = (Driver<T.E>, ActivityIndicator, ErrorTracker)
public typealias DriverActivityBreakdownResult<T: DriverType> = (Driver<T.E>, ActivityIndicator)
public typealias DriverErrorBreakdownResult<T: DriverType> = (Driver<T.E>, ErrorTracker)

public typealias DriverBreakdownFx1<T: DriverType> = (_ obs: T) -> DriverFullBreakdownResult<T>
public typealias DriverBreakdownFx2<T: DriverType & OptionalType> = (_ obs: T) -> DriverFullBreakdownResult<T>?
public typealias DriverBreakdownFx3<T: DriverType> = (_ obs: T) -> DriverActivityBreakdownResult<T>
public typealias DriverBreakdownFx4<T: DriverType & OptionalType> = (_ obs: T) -> DriverActivityBreakdownResult<T>?
public typealias DriverBreakdownFx5<T: DriverType> = (_ obs: T) -> DriverErrorBreakdownResult<T>
public typealias DriverBreakdownFx6<T: DriverType & OptionalType> = (_ obs: T) -> DriverErrorBreakdownResult<T>?

extension DriverType {
  public func breakdown() -> (Driver<E>, ActivityIndicator, ErrorTracker) {
    let activity = ActivityIndicator()
    let error = ErrorTracker()
    let main = trackActivity(activity).trackError(error).asDriverOnErrorJustComplete()
    return (main, activity, error)
  }
}

public func breakdown<T: DriverType>(_ obs: T) -> (Driver<T.E>, ActivityIndicator, ErrorTracker) {
  let activity = ActivityIndicator()
  let error = ErrorTracker()
  let main = obs.trackActivity(activity).trackError(error).asDriverOnErrorJustComplete()
  return (main, activity, error)
}

public func breakdownActivity<T: DriverType>(_ obs: T) -> DriverActivityBreakdownResult<T> {
  let activity = ActivityIndicator()
  let main = obs.trackActivity(activity).asDriverOnErrorJustComplete()
  return (main, activity)
}

public func breakdownError<T: DriverType>(_ obs: T) -> DriverErrorBreakdownResult<T> {
  let error = ErrorTracker()
  let main = obs.trackError(error).asDriverOnErrorJustComplete()
  return (main, error)
}
