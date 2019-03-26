//
// Created by Arnon Keereena on 2019-02-15.
// Copyright (c) 2019 AMOS Thailand. All rights reserved.
//

import Foundation
import SwiftExpansion
import RxSwift
import RxCocoaExpansion

public typealias ObservableFullBreakdownResult<T: ObservableType> = (Observable<T.E>, ActivityIndicator, ErrorTracker)
public typealias ObservableActivityBreakdownResult<T: ObservableType> = (Observable<T.E>, ActivityIndicator)
public typealias ObservableErrorBreakdownResult<T: ObservableType> = (Observable<T.E>, ErrorTracker)

public typealias ObservableBreakdownFx1<T: ObservableType> = (_ obs: T) -> ObservableFullBreakdownResult<T>
public typealias ObservableBreakdownFx2<T: ObservableType & OptionalType> = (_ obs: T) -> ObservableFullBreakdownResult<T>?
public typealias ObservableBreakdownFx3<T: ObservableType> = (_ obs: T) -> ObservableActivityBreakdownResult<T>
public typealias ObservableBreakdownFx4<T: ObservableType & OptionalType> = (_ obs: T) -> ObservableActivityBreakdownResult<T>?
public typealias ObservableBreakdownFx5<T: ObservableType> = (_ obs: T) -> ObservableErrorBreakdownResult<T>
public typealias ObservableBreakdownFx6<T: ObservableType & OptionalType> = (_ obs: T) -> ObservableErrorBreakdownResult<T>?

extension ObservableType {
  public func breakdown() -> (Observable<E>, ActivityIndicator, ErrorTracker) {
    let activity = ActivityIndicator()
    let error = ErrorTracker()
    let main = trackActivity(activity).trackError(error)
    return (main, activity, error)
  }
}

public func breakdown<T: ObservableType>(_ obs: T) -> ObservableFullBreakdownResult<T> {
  let activity = ActivityIndicator()
  let error = ErrorTracker()
  let main = obs.trackActivity(activity).trackError(error)
  return (main, activity, error)
}

public func breakdownActivity<T: ObservableType>(_ obs: T) -> ObservableActivityBreakdownResult<T> {
  let activity = ActivityIndicator()
  let main = obs.trackActivity(activity)
  return (main, activity)
}

public func breakdownError<T: ObservableType>(_ obs: T) -> ObservableErrorBreakdownResult<T> {
  let error = ErrorTracker()
  let main = obs.trackError(error)
  return (main, error)
}
